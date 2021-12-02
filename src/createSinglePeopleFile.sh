cat shexmlOutputPeople/*.ttl > people.ttl
sed -i 's/@prefix.*//g' people.ttl

sed -i "1i\@prefix :      <http://example.com/> ." people.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." people.ttl
sed -i "1i\@prefix ehri_units: <https://data.ehri-project.eu/units/> ." people.ttl
sed -i "1i\@prefix ehri_institution: <https://data.ehri-project.eu/institutions/> ." people.ttl
sed -i "1i\@prefix ehri_pers: <https://data.ehri-project.eu/vocabularies/ehri-pers/> ." people.ttl
sed -i "1i\@prefix ehri:  <https://data.ehri-project.eu/> ." people.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." people.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." people.ttl
sed -i "1i\@prefix ehri_country: <https://data.ehri-project.eu/countries/> ." people.ttl
sed -i "1i\@prefix ehri_terms: <https://data.ehri-project.eu/vocabularies/ehri-terms/> ." people.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." people.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." people.ttl