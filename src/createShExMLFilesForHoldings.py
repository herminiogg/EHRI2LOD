import os
import subprocess
import sys
import hashlib
from multiprocessing import Pool
import multiprocessing as mp
from functools import partial

shexml_first_part = r"""
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX : <http://example.com/>
PREFIX ehri: <https://data.ehri-project.eu/>
PREFIX ehri_country: <https://data.ehri-project.eu/countries/>
#TODO instutions with mixed paths
PREFIX ehri_institution: <https://data.ehri-project.eu/institutions/>
PREFIX ehri_units: <https://data.ehri-project.eu/units/>
PREFIX ehri_terms: <http://data.ehri-project.eu/vocabularies/ehri-terms/>
PREFIX ehri_instantiation: <https://data.ehri-project.eu/instantiations/>
PREFIX ehri_language: <https://data.ehri-project.eu/languages/>
PREFIX ehri_acquisition: <https://data.ehri-project.eu/acquisitions/>
PREFIX dbr: <http://dbpedia.org/resource/>
PREFIX schema: <http://schema.org/>
PREFIX xs: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rico: <https://www.ica.org/standards/RiC/ontology#>
PREFIX ricoVocab: <https://www.ica.org/standards/RiC/vocabularies/documentaryFormTypes#>
SOURCE holdings <file:///C:\Users\Herminio\Downloads\EHRI2LOD\src\holdings\holdings_"""

shexml_second_part = r""".json>

ITERATOR components_iterator <jsonpath: $.data[*]> {
	PUSHED_FIELD id <id>
	PUSHED_FIELD id_if_acquisition <[?(@.attributes.descriptions[*].acquisition)].id>
  	PUSHED_FIELD archived_at <relationships.holder.data.id>
	FIELD parent <relationships.parent.data.id>
	FIELD local_id <attributes.localId>
  	ITERATOR descriptions <attributes.descriptions[*]> {
		FIELD description <*>
    	FIELD name <name>
		FIELD parallel_names <parallelFormsOfName[*]>
		FIELD local_id <localId>
		FIELD local_id_if_acquisition <[?(@.acquisition)].localId>
        FIELD abstract <scopeAndContent>
        FIELD physdesc <extentAndMedium>
        FIELD system_arrangement <systemOfArrangement>
        FIELD bioghist <biographicalHistory>
		FIELD arch_hist <archivalHistory>
        FIELD acquisition <acquisition>
		FIELD dates <unitDates[*]>
		FIELD language_code <languageCode>
		POPPED_FIELD holding_id <id>
		POPPED_FIELD holding_id_if_acquisition <id_if_acquisition>
		POPPED_FIELD archive_id <archived_at>
		ITERATOR language_of_materials <languageOfMaterials> {
			FIELD lang <[*]>
		}

    }
}

EXPRESSION holding <holdings.components_iterator>
EXPRESSION history <holding.descriptions.bioghist + "\n" + holding.descriptions.arch_hist>
EXPRESSION instantiation_id <holdings.components_iterator.descriptions.holding_id + "-" + holdings.components_iterator.descriptions.local_id>
EXPRESSION instantiation_id_if_acquisition <holdings.components_iterator.descriptions.holding_id_if_acquisition + "-" + holdings.components_iterator.descriptions.local_id_if_acquisition>

AUTOINCREMENT person_id <"person_" + 0 to 99999999>
AUTOINCREMENT organization_id <"organization_" + 0 to 99999999>
AUTOINCREMENT genreform_id <"genreform_" + 0 to 99999999>
AUTOINCREMENT authfilenumber_id <"authfilenumber_" + 0 to 99999999>
AUTOINCREMENT location_id <"location" + 0 to 99999999>
AUTOINCREMENT language_id <"language" + 0 to 99999999>
AUTOINCREMENT acquisition_id <"language" + 0 to 99999999>
"""


shexml_third_part = r"""
ehri:ArchiveComponent ehri_units:[holding.id] {
  	a rico:Record ;
	rico:hasDocumentaryFormType ricoVocab:FindingAid ;
    rico:title [holding.descriptions.name] ;
	rdfs:label [holding.descriptions.name] ;
	rico:title [holding.descriptions.parallel_names] ;
	rdfs:label [holding.descriptions.parallel_names] ;
  	rico:scopeAndContent [holding.descriptions.abstract] @[holding.descriptions.language_code] ;
	rico:hasInstantiation @ehri:Instantiation ;
 	rico:recordResourceExtent [holding.descriptions.physdesc] @[holding.descriptions.language_code] ;
	rico:recordResourceStructure [holding.descriptions.system_arrangement] @[holding.descriptions.language_code] ;
	rico:date [holding.descriptions.dates] ;
	rico:isOrWasIncludedIn ehri_units:[holding.parent] ;
	rico:hasOrHadLanguage @ehri:Language ;
	rico:resultsOrResultedFrom @ehri:Acquisition ;
}
   
ehri:Language ehri_language:[holding.descriptions.language_of_materials.lang] {
   	a rico:Language ;
   	rico:name [holding.descriptions.language_of_materials.lang] ;
}

ehri:Instantiation ehri_instantiation:[instantiation_id] {
	a rico:Instantiation ;
	rico:identifier [holding.local_id] ;
	rico:history [holding.descriptions.bioghist] @[holding.descriptions.language_code] ;
	rico:isInstantiationOf ehri_units:[holding.descriptions.holding_id] ;
	rico:title [holding.descriptions.name] @[holding.descriptions.language_code] ;
	rdfs:label [holding.descriptions.name] @[holding.descriptions.language_code] ;
	rico:hasOrHadHolder ehri_institution:[holding.descriptions.archive_id] ;
}

ehri:Acquisition ehri_acquisition:[instantiation_id_if_acquisition] {
	a rico:Activity ;
	rico:type "Acquisition" ;
	rdf:value [holding.descriptions.acquisition] ;
}

ehri:Institution ehri_institution:[holding.descriptions.archive_id] {
	rico:isOrWasHolderOf ehri_instantiation:[instantiation_id] ;
}

ehri:ArchiveComponent ehri_units:[holding.parent] {
	a rico:RecordSet ;
	rico:includesOrIncluded ehri_units:[holding.id] ;
}
"""

created_files = []

def call_shexml(i, output_filename, hash_filename, content_filename):
    subprocess.call(["java", "-Dfile.encoding=UTF-8", "-jar", "ShExML-v0.3.2.jar", "-m", i, "-o", output_filename])
    md5 = hashlib.md5()
    with open(content_filename, "r", encoding="utf-8") as content_file:
        with open(hash_filename, "w") as hash_file:
            md5.update(''.join(content_file.readlines()).encode())
            hash_file.write(md5.hexdigest())

def convert_to_rdf(i, created_files, folder):
    index = created_files.index(i)
    total = str(len(created_files))
    output_filename = "./shexmlOutput/holding_" + str(index + 1) + ".ttl"
    content_filename = "./" + folder + "/holdings_" + str(index + 1) + ".json"
    hash_filename = "./" + folder + "_hash/holdings_" + str(index + 1) + ".md5"
    print("Mapping file " + str(index + 1) + " of " + total + " in " + output_filename)
    if os.path.isfile(output_filename) and os.path.isfile(hash_filename):
        md5 = hashlib.md5()
        with open(hash_filename) as hash_file:
            with open(content_filename, "r", encoding="utf-8") as content_file:
                md5.update(''.join(content_file.readlines()).encode())
            if md5.hexdigest() == ''.join(hash_file.readlines()):
                print("Output file "  + output_filename + " is already up to date")
            else:
                call_shexml(i, output_filename, hash_filename, content_filename)
    else:
        call_shexml(i, output_filename, hash_filename, content_filename)

def get_matcher_contents():
    matchers = ""
    with open("MatcherLanguagesCodes.txt", "r", encoding="utf-8") as content:
        matchers += ''.join(content.readlines()) + "\n"
    with open("MatcherLanguages.txt", "r", encoding="utf-8") as content:
        matchers += ''.join(content.readlines()) + "\n"
    return matchers


if __name__ == '__main__':

    folder = sys.argv[1]
    parallel = sys.argv[2] if len(sys.argv) > 2 else None

    print("Creating ShExML files for holdings in folder: " + folder)

    index = 0
    for i in os.scandir(folder):
        filename = "holdings_" + str(index + 1) + ".shexml"
        f = open("./shexmlRules/" + filename, "w", encoding="utf-8")
        f.write(shexml_first_part + str(index + 1) + shexml_second_part + get_matcher_contents() + shexml_third_part)
        f.close()
        created_files.append("./shexmlRules/" + filename)
        print("Created file " + filename)
        index += 1

    print("Calling ShExML files...")
    number_of_cpus = mp.cpu_count() // 2

    if parallel is not None and parallel == "--parallel":
        with Pool(number_of_cpus) as p:
            p.map(partial(convert_to_rdf, created_files=created_files, folder=folder), created_files)
    else:
        for i in created_files:
            convert_to_rdf(i, created_files, folder)
    
        
           

