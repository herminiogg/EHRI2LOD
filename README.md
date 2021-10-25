# EHRI2LOD
This is a project to download all the contents from the EHRI portal and transform them to Linked Open Data following the schema.org vocabulary.

## Before running the conversion
Have in mind that all the ShExML scripts use absolute paths, so you would have to update them to match your actual path.

## Steps to do the conversion
1. Create the working folders `$ sh createWorkingFolders.sh`
2. Download all the files from the portal `$ python downloader.py`
3. Convert countries and institutions to Turtle
```
$ java -Dfile.encoding=UTF8 -jar ShExML-v0.2.6.jar -m ShExMLTemplates\EAD2SchemaorgLocalCountries.shexml -o countries.ttl

$ java -Dfile.encoding=UTF8 -jar ShExML-v0.2.6.jar -m ShExMLTemplates\EAD2SchemaorgLocalRepositories.shexml -o repositories.ttl
```
4. Convert the holdings to Turtle `$ python createShExMLFilesForHoldings.py holdings`
5. Convert the terms to Turtle `$ python createShExMLFilesForTerms.py terms`
6. Mix all the holdings in a single big Turtle file `$ sh createSingleFile.sh`
7. Mix all the terms in a single big Turtle file `$ sh createSingleTermsFile.sh`