SPARQL query and export to CSV
SELECT ?languageLabel ?code ?language
WHERE 
{
  ?language wdt:P31 wd:Q34770 ;
            wdt:P220 ?code ;
            wdt:P1098 ?speaker .
  SERVICE wikibase:label { bd:serviceParam wikibase:language "en". } 
} ORDER BY DESC (?speaker) LIMIT 200

Creating the Matchers with OpenRefine
First replace the beginning of the URL to get only the Q ID
Then:
Prefix: MATCHER languages_codes <
Row template: "{{cells["languageLabel"].value}}" AS {{cells["code"].value}} 
Row separator: &
Suffix: & "Latin" AS lat>
For the other matcher
Prefix: MATCHER languages <
Row template: "{{cells["languageLabel"].value}}" AS {{cells["language"].value}} 
Row separator: &
Suffix: & "Latin" AS Q397>