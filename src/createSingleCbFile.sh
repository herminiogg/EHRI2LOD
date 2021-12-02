cat shexmlOutputCb/*.ttl > cb.ttl
sed -i 's/@prefix.*//g' cb.ttl

sed -i "1i\@prefix :      <http://example.com/> ." cb.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." cb.ttl
sed -i "1i\@prefix ehri_units: <https://data.ehri-project.eu/units/> ." cb.ttl
sed -i "1i\@prefix ehri_institution: <https://data.ehri-project.eu/institutions/> ." cb.ttl
sed -i "1i\@prefix ehri_cb: <https://data.ehri-project.eu/vocabularies/ehri-cb/> ." cb.ttl
sed -i "1i\@prefix ehri:  <https://data.ehri-project.eu/> ." cb.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." cb.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." cb.ttl
sed -i "1i\@prefix ehri_country: <https://data.ehri-project.eu/countries/> ." cb.ttl
sed -i "1i\@prefix ehri_terms: <https://data.ehri-project.eu/vocabularies/ehri-terms/> ." cb.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." cb.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." cb.ttl