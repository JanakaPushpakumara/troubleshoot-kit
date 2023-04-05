## Java Flight Recorder - Continuous rolling recording

###How to get a rolling recording into disk
* Downlaod and save the file (e.g., jfr_script.sh). And make the script executable 

    Ex:
    ```
    chmod +x jfr_script.sh 
    ```

* Run the script by updating the values of the necessary arguments. The script requires 4 arguments:

    * Duration of each JFR dump in seconds (default: 1802 seconds = 30min )
    * The interval between JFR dumps in seconds (default: 1800 seconds = 30min )
    * Number of JFR dumps to keep (default: 10)
    * Directory to store JFR dumps (default: /temp/jfr )

* The JFR dumps will be created in the specified directory with the file name format jfr_dump_YYYYMMDD_HHMMSS.jfr.
* The script will keep the specified number of JFR dumps in the directory and remove older ones when necessary
