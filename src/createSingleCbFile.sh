cat shexmlOutputCb/*.ttl > cb.ttl
sed -i 's/@prefix.*//g' cb.ttl

sed -i "1i\@prefix :      <http://example.com/> ." cb.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." cb.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." cb.ttl
sed -i "1i\@prefix ehri_institution: <http://lod.ehri-project-test.eu/institutions/> ." cb.ttl
sed -i "1i\@prefix ehri_cb: <http://lod.ehri-project-test.eu/vocabularies/ehri-cb/> ." cb.ttl
sed -i "1i\@prefix ehri:  <http://lod.ehri-project-test.eu/> ." cb.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." cb.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." cb.ttl
sed -i "1i\@prefix ehri_country: <http://lod.ehri-project-test.eu/countries/> ." cb.ttl
sed -i "1i\@prefix ehri_terms: <http://lod.ehri-project-test.eu/vocabularies/ehri-terms/> ." cb.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." cb.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." cb.ttl
sed -i "1i\@prefix owl:    <http://www.w3.org/2002/07/owl#> ." cb.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." cb.ttl
sed -i "1i\@prefix ricoVocab: <https://www.ica.org/standards/RiC/vocabularies/documentaryFormTypes#> ." cb.ttl
sed -i "1i\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ." cb.ttl