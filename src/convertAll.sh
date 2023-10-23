#!/bin/bash

echo "Creating working folders..."
sh createWorkingFolders.sh

echo "Downloading contents from the EHRI portal"
python downloader.py

echo "Converting countries..."
java -Dfile.encoding=UTF8 -jar ShExML-v0.4.0.jar -m ShExMLTemplates/EAD2SchemaorgLocalCountries.shexml -o countries.ttl

echo "Converting institutions..."
java -Dfile.encoding=UTF8 -jar ShExML-v0.4.0.jar -m ShExMLTemplates/EAD2SchemaorgLocalRepositories.shexml -o repositories.ttl

echo "Converting holdings..."
python createShExMLFilesForHoldings.py holdings

echo "Converting terms..."
python createShExMLFilesForTerms.py terms

echo "Converting people..."
python createShExMLFilesForPeople.py people

echo "Converting corporate bodies..."
python createShExMLFilesForCb.py cb

echo "Converting camps..."
python createShExMLFilesForCamps.py camps

echo "Converting ghettos..."
python createShExMLFilesForGhettos.py ghettos

echo "Mixing all the holdings in a single big Turtle file..."
sh createSingleFile.sh

echo "Mixing all the terms in a single big Turtle file..."
sh createSingleTermsFile.sh

echo "Mixing all the people in a single big Turtle file..."
sh createSinglePeopleFile.sh

echo "Mixing all the corporate bodies in a single big Turtle file..."
sh createSingleCbFile.sh

echo "Mixing all the camps in a single big Turtle file..."
sh createSingleCampsFile.sh

echo "Mixing all the ghettos in a single big Turtle file..."
sh createSingleGhettosFile.sh

echo "Creating a single file with all the data..."
sh createSingleFileForDocker.sh
