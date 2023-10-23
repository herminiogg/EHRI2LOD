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
PREFIX ehri_cb: <https://data.ehri-project.eu/vocabularies/ehri-cb/>
PREFIX dbr: <http://dbpedia.org/resource/>
PREFIX schema: <http://schema.org/>
PREFIX xs: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rico: <https://www.ica.org/standards/RiC/ontology#>
SOURCE cb <file:///C:\Users\Herminio\Downloads\EHRI2LOD\src\cb\cb_"""

shexml_second_part = r""".json>

ITERATOR cb_iterator <jsonpath: $.data.AuthoritativeSet.authorities.items[*]> {
	PUSHED_FIELD item_id <identifier>
    FIELD name <description.name>
    FIELD lastName <description.lastName>
    FIELD firstName <description.firstName>
    FIELD languageCode <description.languageCode>
    FIELD sourceLink <description.source>
    FIELD datesOfExistence <description.datesOfExistence>
    FIELD biographicalHistory <description.biographicalHistory>
    FIELD otherFormsOfName <description.otherFormsOfName>
    FIELD parallelFormsOfName <description.parallelFormsOfName>
  	ITERATOR links <links[*]> {
          FIELD fakefield <fakefield>
          ITERATOR targets <targets[?(@.type=='DocumentaryUnit')]> {
              FIELD unit_id <id>
              POPPED_FIELD parent_id <item_id>
          }    
      }
}

EXPRESSION cbs <cb.cb_iterator>

ehri:Thing ehri_cb:[cbs.item_id] {
    a rico:CorporateBody ;
    rdfs:label [cbs.name] @[cbs.languageCode] ;
    owl:sameAs [cbs.sourceLink] ;
    rico:history [cbs.biographicalHistory] @eng ;
}

ehri:Link ehri_units:[cbs.links.targets.unit_id] {
    rico:hasOrHadSubject ehri_cb:[cbs.links.targets.parent_id] ;
}

"""

created_files = []

def call_shexml(i, output_filename):
    subprocess.call(["java", "-Dfile.encoding=UTF-8", "-jar", "ShExML-v0.4.0.jar", "-m", i, "-o", output_filename])

def convert_to_rdf(i, created_files, folder):
    index = created_files.index(i)
    total = str(len(created_files))
    output_filename = "./shexmlOutputCb/cb_" + str(index + 1) + ".ttl"
    content_filename = "./" + folder + "/cb_" + str(index + 1) + ".json"
    print("Mapping file " + str(index + 1) + " of " + total + " in " + output_filename)
    if os.path.isfile(output_filename):
        print("Output file "  + output_filename + " not created as it already exists")
    else:
        call_shexml(i, output_filename)



if __name__ == '__main__':

    folder = sys.argv[1]
    parallel = sys.argv[2] if len(sys.argv) > 2 else None

    print("Creating ShExML files for terms in folder: " + folder)

    index = 0
    for i in os.scandir(folder):
        filename = "cb_" + str(index + 1) + ".shexml"
        f = open("./shexmlRulesCb/" + filename, "w")
        f.write(shexml_first_part + str(index + 1) + shexml_second_part)
        f.close()
        created_files.append("./shexmlRulesCb/" + filename)
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
    
        
           

