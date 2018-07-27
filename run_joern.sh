#!/bin/bash

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ $# -gt 0 ]; then 
    if [ $EUID -ne 0 ]; then
	echo -e "${RED}You may need to run this with sudo${NC}"
    fi
    
    if [ ! -d "$1/.joernIndex" ]; then
	echo -e "${BLUE}Looks like we need to import the code first.${NC}"
	echo -e "Enjoy some beer while you wait \xF0\x9F\x8D\xBA \xF0\x9F\x8D\xBA \xF0\x9F\x8D\xBA\n\n"
	docker run -v $1:/code -p 7474:7474 --rm -w /code  -it neepl/joern java -d64 -Xmx4g -jar /joern/bin/joern.jar .
    fi
    
    echo -e "\n${BLUE}Firing up neo4j!  You can access it at 0.0.0.0:7474${NC}\n"
    docker run -v $1:/code -p 7474:7474 -it neepl/joern /var/lib/neo4j/bin/neo4j console
else
    echo "You need to specify the location of the directory to load"
fi

