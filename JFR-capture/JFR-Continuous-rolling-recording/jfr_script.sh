#!/bin/bash
# Parameters
DURATION=${1:-1802}             # Duration of each JFR dump, default 1802 seconds ( 30min)
INTERVAL=${2:-1800}             # Interval between JFR dumps, default 1800 seconds ( 30min)
DUMPS_TO_KEEP=${3:-10}          # Number of JFR dumps to keep, default 10
DUMP_DIRECTORY=${4:-/temp/jfr}  # Directory to store JFR dumps, default ./jfr
PID=${5:-}                      # Process ID of the Java application

# Check if PID is provided
if [ -z "$PID" ]; then
echo "Error: Please provide the process ID of the Java application as the 5th argument."
exit 1
fi
# Create the dump directory if it does not exist
mkdir -p "$DUMP_DIRECTORY"
# Rolling JFR dump function
take_jfr_dump() {
local timestamp=$(date '+%Y%m%d_%H%M%S')
local file_name="jfr_dump_${timestamp}.jfr"
local file_path="${DUMP_DIRECTORY}/${file_name}"
 # Take the JFR dump
jcmd $PID JFR.start duration=${DURATION}s filename="$file_path"
 # Remove older dumps if necessary
local dump_count=$(ls -1q "$DUMP_DIRECTORY"/*.jfr | wc -l)
 while [ $dump_count -gt $DUMPS_TO_KEEP ]
do
  local oldest_dump=$(ls -1t "$DUMP_DIRECTORY"/*.jfr | tail -1)
  rm -f "$oldest_dump"
  dump_count=$(ls -1q "$DUMP_DIRECTORY"/*.jfr | wc -l)
done
}
# Main loop
while true
do
take_jfr_dump
sleep "$INTERVAL"
done