#!/bin/bash
for f in *correlation.log;
do
echo "******** "$f "******** ";
    cat $f | grep "|" | cut -d "|" -f5 | sort -u | awk NF| while read callType;
    do
        echo $callType;
        cat $f | grep "|$callType|" | cut -d "|" -f4 | sort -n | tail -10

    done
done