#!/bin/bash

TESTS="	lib/field/FieldTest.php
	lib/persistentObj/PersistentObjectTest.php
	lib/search/ObjectSearchTest.php"

for t in $TESTS; do
	echo -e "Testing: $t\n"
	php $t
	echo ""
done


