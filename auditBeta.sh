#!/bin/bash

#muleLogin="curl --silent --location --request POST 'https://anypoint.mulesoft.com/accounts/login' --header 'Content-Type: application/json' -d @auth.json"

muleLogin = "curl --location 'https://anypoint.mulesoft.com/accounts/api/v2/oauth2/token' --header 'Content-Type: application/x-www-form-urlencoded' --header 'Authorization: Basic $creds' --data-urlencode 'grant_type=client_credentials' --data-urlencode 'scope=full'"

muleLoginJSON=$(eval $muleLogin)
accessToken=$(echo $muleLoginJSON | jq -r '.access_token')
echo $accessToken

environmentIds="<your_anypointplatform_environment_id>"
organizationId="<your_anypointplatform_organization_id>"

total=0
currentDate=`date +"%Y-%m-%d %T"`
echo Current date is: ${currentDate}
startDate="2023-01-30 14:59:43"
echo $startDate
while :
do
        queryJSON='{"startDate": "'$startDate'","endDate": "'$currentDate'","platforms": ["Runtime Manager"],"environmentIds": ["'$environmentIds'"],"objectTypes":["Application"],"ascending": false,"organizationId":"'$organizationId'","offset": 0,"limit": 25}'
        #echo "[INFO]$queryJSON"
        audit="curl --silent --location --request POST 'https://anypoint.mulesoft.com/audit/v2/organizations/$organizationId/query' --header 'Authorization: Bearer $accessToken' --header 'Content-Type: application/json' -d '$queryJSON'"
        auditJSON=$(eval $audit)
        echo "[INFO] #########################################"
        echo $auditJSON
        totalJSON=$(echo $auditJSON | jq -r '.total')
        echo "Total of new events: $totalJSON"
        if [ $totalJSON -gt $total ]
          then
              echo "[INFO] Event(s) send to syslog"
              echo $auditJSON  > /dev/udp/yourUDP_server/yourUDP_port
          else
              echo "[INFO] There are no new events."
        fi
        sleep 5
        startDate=$currentDate
        currentDate=`date +"%Y-%m-%d %T"`
        echo "[INFO] StartDate $startDate"
        echo "[INFO] EndDate $currentDate"
done
