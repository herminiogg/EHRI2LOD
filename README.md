# EHRI2LOD
This is a project to download all the contents from the EHRI portal and transform them to Linked Open Data following the schema.org vocabulary.

## Before running the conversion
Have in mind that all the ShExML scripts use absolute paths, so you would have to update them to match your actual path.

## Steps to do the conversion
1. Download all the files from the portal `$ python downloader.py`
2. Convert countries and institutions to Turtle
```
$ java -jar ShExML-v0.2.6.jar -m ShExMLTemplates\EAD2SchemaorgLocalCountries.shexml -o countries.ttl

$ java -jar ShExML-v0.2.6.jar -m ShExMLTemplates\EAD2SchemaorgLocalRepositories.shexml -o repositories.ttl
```
3. Convert the holdings to Turtle `$ python createShExMLFilesForHoldings.py holdings`
4. Mix all the holdings in a single big Turtle file `$ sh createSingleFile.sh`
5. Put prefixes in holdings.ttl, you can get them from any of the holdings_x.ttl file.