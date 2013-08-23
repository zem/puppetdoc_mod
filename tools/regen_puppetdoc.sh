#!/bin/bash

TARGET=/srv/www/htdocs/puppetdoc
MODULES=/etc/puppet/modules

#Generate Changelog for module 
(
	cd $MODULES
	for i in * 
	do
		cd $i
		echo "== Changelog:" > README
		echo >> README
		git log . | (
				while read foo
				do 
					echo " ${foo}" >> README
				done
		)
		cd ..
	done
)








rm -r ${TARGET}
puppetdoc --verbose --all --charset utf-8  -o ${TARGET} -m rdoc --manifest=/etc/puppet/manifests/site.pp

find ${TARGET}/classes -name *.html -exec /etc/puppet/tools/rewrite_param_list.pl {} \; 

#puppetdoc --charset utf-8  --outputdir ${TARGET} --mode rdoc --manifest=/etc/puppet/manifests/site.pp
