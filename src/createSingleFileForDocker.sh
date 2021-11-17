curl https://portal.ehri-project.eu/vocabularies/ehri_terms/export?format=TTL > ehri-terms.ttl
curl https://portal.ehri-project.eu/vocabularies/ehri_camps/export?format=TTL > ehri-camps.ttl
curl https://portal.ehri-project.eu/vocabularies/ehri_ghettos/export?format=TTL > ehri-ghettos.ttl

rm all.ttl

cat *.ttl > all.ttl
sed -i 's/@prefix.*//g' all.ttl

sed -i "1i\@prefix :      <http://example.com/> ." all.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." all.ttl
sed -i "1i\@prefix ehri_units: <https://data.ehri-project.eu/units/> ." all.ttl
sed -i "1i\@prefix ehri_institution: <https://data.ehri-project.eu/institutions/> ." all.ttl
sed -i "1i\@prefix ehri:  <https://data.ehri-project.eu/> ." all.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." all.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." all.ttl
sed -i "1i\@prefix ehri_country: <https://data.ehri-project.eu/countries/> ." all.ttl
sed -i "1i\@prefix ehri_terms: <http://data.ehri-project.eu/vocabularies/ehri-terms/> ." all.ttl
sed -i "1i\@prefix ehri_camps: <http://data.ehri-project.eu/vocabularies/ehri-camps/> ." all.ttl
sed -i "1i\@prefix ehri_ghettos: <http://data.ehri-project.eu/vocabularies/ehri-ghettos/> ." all.ttl
sed -i "1i\@prefix ehri_pers: <http://data.ehri-project.eu/vocabularies/ehri-pers/> ." all.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." all.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." all.ttl
sed -i "1i\@prefix geo:     <http://www.w3.org/2003/01/geo/wgs84_pos#> ." all.ttl
sed -i "1i\@prefix owl:     <http://www.w3.org/2002/07/owl#> ." all.ttl
sed -i "1i\@prefix skos:    <http://www.w3.org/2004/02/skos/core#> ." all.ttl
sed -i "1i\@prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> ." all.ttl
sed -i "1i\@prefix sem:     <http://semanticweb.cs.vu.nl/2009/11/sem/> ." all.ttl
sed -i "1i\@prefix foaf:    <http://xmlns.com/foaf/0.1/> ." all.ttl
sed -i "1i\@prefix dc:      <http://purl.org/dc/elements/1.1/name> ." all.ttl