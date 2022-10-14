# correlation log file analyzing script

This shell script will extract the max latencies reported in the correlation log file. 

## Run the script
* Copy the script in to the folrder which contains the correlation log file
* Run the script with the command
``` sh correlation-log-analyzer.sh ```


## grep command cheat sheet

#### PassThroughMessageProcessor thread count
``` grep "PassThroughMessageProcessor-" correlation.log | cut -d "|" -f3 | sort  -ru  | wc -l ```

