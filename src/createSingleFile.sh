cat shexmlOutput/*.ttl > holdings.ttl
sed -i 's/@prefix.*//g' holdings.ttl