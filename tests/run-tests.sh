#!/bin/sh

# This must be set manually for now */
PHP_SRCDIR="/noe/php/source";

export TEST_PHP_EXECUTABLE="$PHP_SRCDIR/sapi/cli/php"
export -n NO_INTERACTION
export TEST_PHP_DETAILED

$TEST_PHP_EXECUTABLE -q $PHP_SRCDIR/run-tests.php .
