cat shexmlOutput/*.ttl > holdings.ttl
sed -i 's/@prefix.*//g' holdings.ttl

sed -i "1i\@prefix :      <http://example.com/> ." holdings.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." holdings.ttl
sed -i "1i\@prefix ehri_units: <https://data.ehri-project.eu/units/> ." holdings.ttl
sed -i "1i\@prefix ehri_institution: <https://data.ehri-project.eu/institutions/> ." holdings.ttl
sed -i "1i\@prefix ehri:  <https://data.ehri-project.eu/> ." holdings.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." holdings.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." holdings.ttl
sed -i "1i\@prefix ehri_country: <https://data.ehri-project.eu/countries/> ." holdings.ttl
sed -i "1i\@prefix ehri_terms: <http://data.ehri-project.eu/vocabularies/ehri-terms/> ." holdings.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." holdings.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." holdings.ttl