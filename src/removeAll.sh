#!/bin/bash

echo "Removing files..."

rm all.ttl
rm allWithExtras.ttl
rm camps.ttl
rm cb.ttl
rm countries.ttl
rm ehri-terms.ttl
rm ehri-camps.ttl
rm ehri-ghettos.ttl
rm ghettos.ttl
rm holdings.ttl
rm people.ttl
rm terms.ttl

echo "Removing folders..."

rm -rf camps
rm -rf cb
rm -rf countries
rm -rf ghettos
rm -rf holdings
rm -rf holdings_hash
rm -rf institutions
rm -rf terms
rm -rf people
rm -rf shexmlOutput
rm -rf shexmlOutputCamps
rm -rf shexmlOutputCb
rm -rf shexmlOutputGhettos
rm -rf shexmlOutputPeople
rm -rf shexmlOutputTerms
rm -rf shexmlRules
rm -rf shexmlRulesCamps
rm -rf shexmlRulesCb
rm -rf shexmlRulesGhettos
rm -rf shexmlRulesPeople
rm -rf shexmlRulesTerms

echo "Everything has been removed. You can start anew!"