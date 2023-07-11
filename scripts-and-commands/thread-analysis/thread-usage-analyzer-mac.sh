#!/bin/bash
if [ "$#" -ne 2 ]; then
  echo "usage: sh ThreadDumpUsageAnalyzer.sh <PID> <high CPU thread result count>"
  exit
fi

PID=$1
RESULTCOUNT=$2

echo  "*****  START ***** ";
for f in thread_usage*.txt;
    do
        # echo 'start of thead usesage analysis' $f;
        DATETIME=$( echo ${f} | cut -b 14- )
        #!echo "$DATETIME"
        TDDumpL=$(find . -name "thread_dump_$DATETIME");
        if [ -z "$TDDumpL" ]; then
            echo "There is not corresponding thread_dump file which matches to the thread_usage file -" $f "hence aborting the procesing!!!"
        else
            TDDumpS=$(echo $TDDumpL | cut -d '/' -f 2)
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
            echo 'start of the analysis for the file' $TDDumpS '-' $f;
            #! View thread usage column names
            echo "  PID   TID %CPU     TIME NLWP  C | JAVAThread ";
            #!echo " " ${f};
            VAR=$(grep $PID $f | sort -nk3 | tail -n $RESULTCOUNT )
            grep $PID $f | sort -nk3 | tail -n $RESULTCOUNT | while read usage_line ;
                do
                    printf "$usage_line";
                    #! Native OS and JVA thread ID mapping
                    NTID=$(echo "$usage_line" | awk  '{print $2}' );
                    NTIDHEX=$(echo "obase=16; $NTID "| bc | awk '{print tolower($0)}');

                    #! View decimal to hexadecimal mapping
                    #!echo -n " | $NTID";
                    #!echo -n " Hexa>> ";
                    #!echo -n "$NTIDHEX | ";

                    printf " | ";
                    grep "nid=0x$NTIDHEX " $TDDumpL;
                done;
            echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
        fi
    done;
echo  "*****  END ***** ";
echo "";