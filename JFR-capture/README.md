## JFR dump

Java Flight Recorder (JFR) is a tool for collecting diagnostic and profiling data about a running Java application. It is integrated into the Java Virtual Machine (JVM) and causes almost no performance overhead, so it can be used even in heavily loaded production environments. When default settings are used, both internal testing and customer feedback indicate that performance impact is less than one percent. For some applications, it can be significantly lower. However, for short-running applications (which are not the kind of applications running in production environments), relative startup and warmup times can be larger, which might impact the performance by more than one percent.

JFR collects data about the JVM as well as the Java application running on it.

### How to get ?

* Get the WSO2 server process_id
* Enable JFR feature (Java Flight Recorder requires a commercial license for use in production).

  Before Java 11, both Java Flight Recorder (JFR) and Java Mission Control (JMC) are commercial products
and only available in Oracle JDK, and we can enable the JFR features via the following commands:
    ``` 
     jcmd <process_id> VM.unlock_commercial_features
    ```
    Now, the JFR is open source in OpenJDK 11, and available in the OpenJDK11/bin folder; while the JMC is not part of the JDK anymore, we can download [here](https://jdk.java.net/jmc/).
* Obtain the JFR dump
    ```
    jcmd <process_id> JFR.start name=WSO2_profiling duration=30m filename=<PATH>/WSO2Server_profiling-`date +%d-%m-%Y-%H:%M:%S`.jfr
    ```
* Stop to JFR
    ```
    jcmd <process_id> JFR.stop name=WSO2_profiling
    ```

### Available parameters 

- duration
- filename
- maxsize

### Diagnostic Commands

`JFR.start`

Start a recording.

`JFR.check`

Check the status of all recordings running for the specified process, including the recording identification number, file name, duration, and so on.

`JFR.stop`

Stop a recording with a specific identification number (by default, recording 1 is stopped).

`JFR.dump`

Dump the data collected so far by the recording with a specific identification number (by default, data from recording 1 is dumped).




