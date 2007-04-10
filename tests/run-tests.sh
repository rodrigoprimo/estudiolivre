#!/bin/sh

# This must be set manually for now */

export TEST_PHP_EXECUTABLE="php"
export -n NO_INTERACTION
export TEST_PHP_DETAILED

$TEST_PHP_EXECUTABLE -q $PHP_SRCDIR/run-tests.php .
