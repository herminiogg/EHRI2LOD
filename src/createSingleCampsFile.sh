cat shexmlOutputCamps/*.ttl > camps.ttl
sed -i 's/@prefix.*//g' camps.ttl

sed -i "1i\@prefix :      <http://example.com/> ." camps.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." camps.ttl
sed -i "1i\@prefix ehri_units: <https://data.ehri-project.eu/units/> ." camps.ttl
sed -i "1i\@prefix ehri_institution: <https://data.ehri-project.eu/institutions/> ." camps.ttl
sed -i "1i\@prefix ehri:  <https://data.ehri-project.eu/> ." camps.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." camps.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." camps.ttl
sed -i "1i\@prefix ehri_country: <https://data.ehri-project.eu/countries/> ." camps.ttl
sed -i "1i\@prefix ehri_camps: <https://data.ehri-project.eu/vocabularies/ehri-camps/> ." camps.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." camps.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." camps.ttl
sed -i "1i\@prefix owl:    <http://www.w3.org/2002/07/owl#> ." camps.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." camps.ttl
sed -i "1i\@prefix ricoVocab: <https://www.ica.org/standards/RiC/vocabularies/documentaryFormTypes#> ." camps.ttl
sed -i "1i\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ." camps.ttl