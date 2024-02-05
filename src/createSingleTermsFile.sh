cat shexmlOutputTerms/*.ttl > terms.ttl
sed -i 's/@prefix.*//g' terms.ttl

sed -i "1i\@prefix :      <http://example.com/> ." terms.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." terms.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." terms.ttl
sed -i "1i\@prefix ehri_institution: <http://lod.ehri-project-test.eu/institutions/> ." terms.ttl
sed -i "1i\@prefix ehri:  <http://lod.ehri-project-test.eu/> ." terms.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." terms.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." terms.ttl
sed -i "1i\@prefix ehri_country: <http://lod.ehri-project-test.eu/countries/> ." terms.ttl
sed -i "1i\@prefix ehri_terms: <http://lod.ehri-project-test.eu/vocabularies/ehri-terms/> ." terms.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." terms.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." terms.ttl
sed -i "1i\@prefix owl:    <http://www.w3.org/2002/07/owl#> ." terms.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." terms.ttl
sed -i "1i\@prefix ricoVocab: <https://www.ica.org/standards/RiC/vocabularies/documentaryFormTypes#> ." terms.ttl
sed -i "1i\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ." terms.ttl