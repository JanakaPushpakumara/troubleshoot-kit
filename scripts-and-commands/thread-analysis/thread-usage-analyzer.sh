#!/bin/bash
if [ "$#" -ne 1 ]; then
        echo "usage: sh ThreadDumpUsageAnalyzer.sh <PID> <high CPU thread result count>"
        exit
fi

PID=$(grep "" thread_usage_* | grep -v PID |awk  '{print $2}' | sort | uniq ;)
RESULTCOUNT=$1

echo  "*****  START ***** ";
for f in thread_usage*.txt;
do
        echo -n ${f} "";
        DATETIME=$( echo ${f} | cut -b 14- )
        #!echo "$DATETIME"
        find -name thread_dump*$DATETIME;
        #! View thread usage column names
        echo "  PID   TID %CPU     TIME NLWP  C | JAVAThread ";
        #!echo " " ${f};
        VAR=$(grep $PID $f | sort -rnk3 | head -n $RESULTCOUNT )
        grep $PID $f | sort -rnk3 | head -n $RESULTCOUNT | while read usage_line ;
        do
        	echo -n "$usage_line";
        	#! Native OS and JVA thread ID mapping
        	NTID=$(echo "$usage_line" | awk  '{print $2}' );
        	NTIDHEX=$(echo  "obase=16; $NTID "| bc | awk '{print tolower($0)}');
        	
        	#! View decimal to hexadecimal mapping
        	#!echo -n " | $NTID";
        	#!echo -n " Hexa>> ";
        	#!echo -n "$NTIDHEX | ";
        	
        	echo -n " | ";
        	grep "nid=0x$NTIDHEX" thread_dump*$DATETIME;

        done;
        echo  "*****  END ***** ";
        echo "";
done;
