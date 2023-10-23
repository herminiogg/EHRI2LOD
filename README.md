# EHRI2LOD
This is a project to download all the contents from the EHRI portal and transform them to Linked Open Data following the [Records in Context ontology](https://www.ica.org/standards/RiC/RiC-O_v0-2.html). The mapping rules try to align as much as possible to the EHRI data model (following EAD mostly) to the RiC data model. When this is not possible general vocabulary terms from [schema.org](https://schema.org/) are used. For particular terms that are only used inside the EHRI domain (mostly in the countries' information) custom predicates are used which at some point will be compiled into a custom and proper ontology.

## Before running the conversion
Have in mind that all the ShExML scripts use absolute paths, so you would have to update them to match your actual path. Since ShExML v0.2.7 relative paths are supported for local files, so you can expect this to be adapted in the future.

## Steps to do the conversion
1. Create the working folders `$ sh createWorkingFolders.sh`
2. Download all the files from the portal `$ python downloader.py`
3. Convert countries and institutions to Turtle
```
$ java -Dfile.encoding=UTF8 -jar ShExML-v0.4.0.jar -m ShExMLTemplates\EAD2SchemaorgLocalCountries.shexml -o countries.ttl

$ java -Dfile.encoding=UTF8 -jar ShExML-v0.4.0.jar -m ShExMLTemplates\EAD2SchemaorgLocalRepositories.shexml -o repositories.ttl
```
4. Convert the holdings to Turtle `$ python createShExMLFilesForHoldings.py holdings`
5. Convert the terms to Turtle `$ python createShExMLFilesForTerms.py terms`
6. Convert the people (EHRI personalities) to Turtle `$ python createShExMLFilesForPeople.py people`
7. Convert the corporate bodies to Turtle `$ python createShExMLFilesForCb.py cb`
8. Convert the camps to Turtle `$ python createShExMLFilesForCamps.py camps`
9. Convert the ghettos to Turtle `$ python createShExMLFilesForGhettos.py ghettos`
10. Mix all the holdings in a single big Turtle file `$ sh createSingleFile.sh`
11. Mix all the terms in a single big Turtle file `$ sh createSingleTermsFile.sh`
12. Mix all the people in a single big Turtle file `$ sh createSinglePeopleFile.sh`
13. Mix all the corporate bodies in a single big Turtle file `$ sh createSingleCbFile.sh`
14. Mix all the camps in a single big Turtle file `$ sh createSingleCampsFile.sh`
15. Mix all the ghettos in a single big Turtle file `$ sh createSingleGhettosFile.sh`
16. (optional) Create a single file with all the data `$ sh createSingleFileForDocker.sh`

Alternatively, you can run the whole process unattendedly using `$ sh convertAll.sh`

## Docker
It is possible to launch a Docker container to visualise the generated data in a LOD viewer. For doing this you can use the the provided Dockerfile. You can either build or pull from Docker hub with the last generated data.
Build:
```
$ docker build -t herminiogg/ehri2lod .
```
or Pull:
```
$ docker pull herminiogg/ehri2lod
```
Launch:
```
$ docker run -p 8080:8080 -p 3030:3030 herminiogg/ehri2lod
```
## Additional resources
As part of the process additional resources were also generated and are attached to this repository for documentation purpouses. You can find these files under the auxFile folder which contains fragments of queries and other constructions used in the development of the whole workflow.

### Shapes
One special output from the process are the ShEx and SHACL shapes generated directly from the ShExML mapping rules (see [ShEx generation from ShExML](http://shexml.herminiogarcia.com/validation/shex.html)). Take into account that, due to the big amount of data, these shapes are generated from a small set of data, meaning that cardinalities and data types may not be 100% accurate. The files can be found in the shapes folder.

## Future work
* Create a process to incrementally update the data

