# MuleSoft Audit Logs Utility
Contains a sample shell based application that constantly query the audit logs of Anypoint Platform.

This tool is going to be polling the Audit Log Query API and query for new events. Currently contains the logic to retrieve Applications events, such as: Deploy, Create, Start, Delete. This can be for CloudHub, Standalone, Runtime Fabric, etc.

If new events are detected, those will be send to a syslog UDP based system for consolidation.

As previously mentioned, this shell based applications uses the MuleSoft Anypoint Platform Audit Log Query API. The official MuleSoft documentation can be found [here](https://anypoint.mulesoft.com/exchange/portals/anypoint-platform/f1e97bc6-315a-4490-82a7-23abe036327a.anypoint-platform/audit-log-query-api/)

## Pre-requisites

- Mulesoft credentials
- Linux based system to run the utility

## Execution

In order to execute it you just need to write your credentials in file auth.json.

Also you need to set:
- Your environment ID where you want to get the events. **Line 9 of auditBeta.sh.**
- Your organzation ID. **Line 10 of auditBeta.sh**
- Your UPD Server and UPD port where you want to send the events. **Line 28 of auditBeta.sh.**
- The start date from where you want to start getting the audit logs. **Line 15 of auditBeta.sh.**

If you do not know where to get the **environment ID** and **organization ID**, you can get it from here:

**Organization ID** 

https://help.mulesoft.com/s/article/How-to-know-my-Organization-ID-Org-ID-on-the-Anypoint-Platform 

**Environment ID** 

https://help.mulesoft.com/s/article/How-to-get-the-Environment-ID

Once you run it, it will start pulling the events based on the start date, and then every five seconds (**Line 32 of auditBeta.sh**), it will look for new events.


## TO-DO

- Parametrized the ammount of seconds to wait for new events
- Parametrized the udp server and port
- Renew the access token once it is expired
- Include more events and ways to access them
