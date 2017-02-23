#!/bin/bash

## Debug avec valgrind + compil avec -g
./clean
./docmatlab2R r_spams
./mybuild -g

## running test script
TEST=
case $1 in
    1) TEST=tstlasso.R;;
    2) TEST=tstgm.R;;
    3) TEST=tstfista.R;;
    4) TEST=tstprox.R;;
    5) TEST=tsttraindl.R;;
    6) TEST=tsttraindl.R;;
    *) echo "BAD OPTION $1";;
esac

if [ -n $1 ];
then
    echo $TEST
    R -d "valgrind --tool=memcheck --log-file=log" --vanilla < $TEST
fi
