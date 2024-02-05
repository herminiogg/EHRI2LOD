cat shexmlOutputPeople/*.ttl > people.ttl
sed -i 's/@prefix.*//g' people.ttl

sed -i "1i\@prefix :      <http://example.com/> ." people.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." people.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." people.ttl
sed -i "1i\@prefix ehri_institution: <http://lod.ehri-project-test.eu/institutions/> ." people.ttl
sed -i "1i\@prefix ehri_pers: <http://lod.ehri-project-test.eu/vocabularies/ehri-pers/> ." people.ttl
sed -i "1i\@prefix ehri_pers_full_name: <http://lod.ehri-project-test.eu/vocabularies/ehri-pers/name/> ." people.ttl
sed -i "1i\@prefix ehri_pers_other_form_name: <http://lod.ehri-project-test.eu/vocabularies/ehri-pers/other-name/> ." people.ttl
sed -i "1i\@prefix ehri_pers_parallel_form_name: <http://lod.ehri-project-test.eu/vocabularies/ehri-pers/parallel-name/> ." people.ttl
sed -i "1i\@prefix ehri:  <http://lod.ehri-project-test.eu/> ." people.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." people.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." people.ttl
sed -i "1i\@prefix ehri_country: <http://lod.ehri-project-test.eu/countries/> ." people.ttl
sed -i "1i\@prefix ehri_terms: <http://lod.ehri-project-test.eu/vocabularies/ehri-terms/> ." people.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." people.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." people.ttl
sed -i "1i\@prefix owl:    <http://www.w3.org/2002/07/owl#> ." people.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." people.ttl
sed -i "1i\@prefix ricoVocab: <https://www.ica.org/standards/RiC/vocabularies/documentaryFormTypes#> ." people.ttl
sed -i "1i\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ." people.ttl