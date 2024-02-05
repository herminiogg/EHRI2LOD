cat shexmlOutput/*.ttl > holdings.ttl
sed -i 's/@prefix.*//g' holdings.ttl

sed -i "1i\@prefix :      <http://example.com/> ." holdings.ttl
sed -i "1i\@prefix schema: <http://schema.org/> ." holdings.ttl
sed -i "1i\@prefix ehri_units: <http://lod.ehri-project-test.eu/units/> ." holdings.ttl
sed -i "1i\@prefix ehri_institution: <http://lod.ehri-project-test.eu/institutions/> ." holdings.ttl
sed -i "1i\@prefix ehri_instantiation: <http://lod.ehri-project-test.eu/instantiations/> ." holdings.ttl
sed -i "1i\@prefix ehri:  <http://lod.ehri-project-test.eu/> ." holdings.ttl
sed -i "1i\@prefix dbr:   <http://dbpedia.org/resource/> ." holdings.ttl
sed -i "1i\@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> ." holdings.ttl
sed -i "1i\@prefix ehri_country: <http://lod.ehri-project-test.eu/countries/> ." holdings.ttl
sed -i "1i\@prefix ehri_terms: <http://lod.ehri-project-test.eu/vocabularies/ehri-terms/> ." holdings.ttl
sed -i "1i\@prefix ehri_instantiation: <http://lod.ehri-project-test.eu/instantiations/> ." holdings.ttl
sed -i "1i\@prefix ehri_language: <http://lod.ehri-project-test.eu/languages/> ." holdings.ttl
sed -i "1i\@prefix ehri_acquisition: <http://lod.ehri-project-test.eu/acquisitions/> ." holdings.ttl
sed -i "1i\@prefix xs:    <http://www.w3.org/2001/XMLSchema#> ." holdings.ttl
sed -i "1i\@prefix wd:    <http://www.wikidata.org/entity/> ." holdings.ttl
sed -i "1i\@prefix owl:    <http://www.w3.org/2002/07/owl#> ." holdings.ttl
sed -i "1i\@prefix rico: <https://www.ica.org/standards/RiC/ontology#> ." holdings.ttl
sed -i "1i\@prefix ricoVocab: <https://www.ica.org/standards/RiC/vocabularies/documentaryFormTypes#> ." holdings.ttl
sed -i "1i\@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ." holdings.ttl