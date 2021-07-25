# Mulesoft Audit Logs
Contains a sample application to constantly query the audit logs of Anypoint Platform.

This tool is going to be polling the Audit API and query for new events.
If new events are detected, those will be send to a syslog UDP based system for consolidation.

## Pre-requisites

- Mulesoft credentials
- Linux based system to run the utility
