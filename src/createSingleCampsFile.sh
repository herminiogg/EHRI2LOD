cat shexmlOutputCamps/*.ttl > camps.ttl
sed -i 's/@prefix.*//g' camps.ttl

sed -i "1i\@prefix :      <http://example.com/> ." camps.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." camps.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." camps.ttl
sed -i "1i\@prefix ehri_institution: <http://lod.ehri-project-test.eu/institutions/> ." camps.ttl
sed -i "1i\@prefix ehri:  <http://lod.ehri-project-test.eu/> ." camps.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." camps.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." camps.ttl
sed -i "1i\@prefix ehri_country: <http://lod.ehri-project-test.eu/countries/> ." camps.ttl
sed -i "1i\@prefix ehri_camps: <http://lod.ehri-project-test.eu/vocabularies/ehri-camps/> ." camps.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." camps.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." camps.ttl
sed -i "1i\@prefix owl:    <http://www.w3.org/2002/07/owl#> ." camps.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." camps.ttl
sed -i "1i\@prefix ricoVocab: <https://www.ica.org/standards/RiC/vocabularies/documentaryFormTypes#> ." camps.ttl
sed -i "1i\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ." camps.ttl