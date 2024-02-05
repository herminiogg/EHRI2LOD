cat shexmlOutputGhettos/*.ttl > ghettos.ttl
sed -i 's/@prefix.*//g' ghettos.ttl

sed -i "1i\@prefix :      <http://example.com/> ." ghettos.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." ghettos.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." ghettos.ttl
sed -i "1i\@prefix ehri_institution: <http://lod.ehri-project-test.eu/institutions/> ." ghettos.ttl
sed -i "1i\@prefix ehri:  <http://lod.ehri-project-test.eu/> ." ghettos.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." ghettos.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." ghettos.ttl
sed -i "1i\@prefix ehri_country: <http://lod.ehri-project-test.eu/countries/> ." ghettos.ttl
sed -i "1i\@prefix ehri_ghettos: <http://lod.ehri-project-test.eu/vocabularies/ehri-ghettos/> ." ghettos.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." ghettos.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." ghettos.ttl
sed -i "1i\@prefix owl:    <http://www.w3.org/2002/07/owl#> ." ghettos.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." ghettos.ttl
sed -i "1i\@prefix ricoVocab: <https://www.ica.org/standards/RiC/vocabularies/documentaryFormTypes#> ." ghettos.ttl
sed -i "1i\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ." ghettos.ttl