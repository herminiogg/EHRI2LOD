cat shexmlOutputTerms/*.ttl > terms.ttl
sed -i 's/@prefix.*//g' terms.ttl

sed -i "1i\@prefix :      <http://example.com/> ." terms.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." terms.ttl
sed -i "1i\@prefix ehri_units: <https://data.ehri-project.eu/units/> ." terms.ttl
sed -i "1i\@prefix ehri_institution: <https://data.ehri-project.eu/institutions/> ." terms.ttl
sed -i "1i\@prefix ehri:  <https://data.ehri-project.eu/> ." terms.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." terms.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." terms.ttl
sed -i "1i\@prefix ehri_country: <https://data.ehri-project.eu/countries/> ." terms.ttl
sed -i "1i\@prefix ehri_terms: <https://data.ehri-project.eu/vocabularies/ehri-terms/> ." terms.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." terms.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." terms.ttl