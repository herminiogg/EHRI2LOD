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
PREFIX dbr: <http://dbpedia.org/resource/>
PREFIX schema: <http://schema.org/>
PREFIX xs: <http://www.w3.org/2001/XMLSchema#>
SOURCE holdings <file:///C:\Users\Herminio\Downloads\EHRI2LOD\src\holdings\holdings_"""

shexml_second_part = r""".json>

ITERATOR components_iterator <jsonpath: $.data[*]> {
	FIELD id <id>
  	FIELD archived_at <relationships.holder.data.id>
    FIELD parent <relationships.parent.data.id>
  	ITERATOR descriptions <attributes.descriptions[*]> {
    	FIELD name <name>
        FIELD abstract <scopeAndContent>
        FIELD physdesc <extentAndMedium>
        FIELD description <systemOfArrangement>
        FIELD bioghist <biographicalHistory>
        FIELD credit_text <acquisition>
    	FIELD language_of_materials <languageOfMaterials>
    }
}


EXPRESSION holding <holdings.components_iterator>

AUTOINCREMENT person_id <"person_" + 0 to 99999999>
AUTOINCREMENT organization_id <"organization_" + 0 to 99999999>
AUTOINCREMENT genreform_id <"genreform_" + 0 to 99999999>
AUTOINCREMENT authfilenumber_id <"authfilenumber_" + 0 to 99999999>
AUTOINCREMENT location_id <"location" + 0 to 99999999>

MATCHER languages <English AS Q1860 &
	German AS Q188 &
	Hebrew AS Q9288 >
  
MATCHER languages_codes <English AS eng &
	German AS deu &
	Hebrew AS heb >

ehri:ArchiveComponent ehri_units:[holding.id] {
  	a schema:ArchivalHolding ;
    schema:name [holding.descriptions.name] ;
  	schema:abstract [holding.descriptions.abstract] ;
 	schema:materialExtent [holding.descriptions.physdesc] ;
  	schema:holdingArchive ehri_institution:[holding.archived_at] ;
  	schema:text [holding.descriptions.bioghist] ;
	schema:description [holding.descriptions.description] xs:string ;
  	schema:creditText [holding.descriptions.credit_text] ;
    schema:isPartOf ehri_units:[holding.parent] ;
  	schema:inLanguage ehri:[holding.descriptions.language_of_materials];
}
   
ehri:Language ehri:[holding.descriptions.language_of_materials] {
   	a schema:Language ;
   	schema:name [holding.descriptions.language_of_materials] ;
   	schema:alternateName [holding.descriptions.language_of_materials MATCHING languages_codes] ;
  	schema:sameAs wd:[holding.descriptions.language_of_materials MATCHING languages] ;
}
"""

created_files = []

def call_shexml(i, output_filename, hash_filename, content_filename):
    subprocess.call(["java", "-Dfile.encoding=UTF-8", "-jar", "ShExML-v0.2.6.jar", "-m", i, "-o", output_filename])
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



if __name__ == '__main__':

    folder = sys.argv[1]
    parallel = sys.argv[2] if len(sys.argv) > 2 else None

    print("Creating ShExML files for holdings in folder: " + folder)

    index = 0
    for i in os.scandir(folder):
        filename = "holdings_" + str(index + 1) + ".shexml"
        f = open("./shexmlRules/" + filename, "w")
        f.write(shexml_first_part + str(index + 1) + shexml_second_part)
        f.close()
        created_files.append("./shexmlRules/" + filename)
        print("Created file " + filename)
        index += 1

    print("Calling ShExML files...")
    number_of_cpus = mp.cpu_count()

    if parallel is not None and parallel == "--parallel":
        with Pool(number_of_cpus) as p:
            p.map(partial(convert_to_rdf, created_files=created_files, folder=folder), created_files)
    else:
        for i in created_files:
            convert_to_rdf(i, created_files, folder)
    
        
           

