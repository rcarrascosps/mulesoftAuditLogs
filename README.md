# Mulesoft Audit Logs
Contains a sample application to constantly query the audit logs of Anypoint Platform.

This tool is going to be polling the Audit API and query for new events.
If new events are detected, those will be send to a syslog UDP based system for consolidation.

## Pre-requisites

- Mulesoft credentials
- Linux based system to run the utility

## Execution

In order to execute it you just need to write your credentials in file auth.json.
Also you need to set:
- Your environment ID where you want to get the events. Line 9.
- Your organzation ID. Line 10
- Your UPD Server and UPD port where you want to send the events. Line 31

If you do not know where to get the environment ID and organization ID, you can get it from here:

**Organization ID** 
https://help.mulesoft.com/s/article/How-to-know-my-Organization-ID-Org-ID-on-the-Anypoint-Platform 

**Environment ID** 
https://help.mulesoft.com/s/article/How-to-get-the-Environment-ID

