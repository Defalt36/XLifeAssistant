#!/bin/bash

for directory in $GAMEDIR $MINORDIR $SERVERDIR ; do
    find $directory -type f -name '*.o' -exec rm -f {} +
    find $directory -type f -name '*.dep' -exec rm -f {} +
    find $directory -type f -name '*.dep2' -exec rm -f {} +
done