#!/bin/bash

muleLogin="curl --silent --location --request POST 'https://anypoint.mulesoft.com/accounts/login' --header 'Content-Type: application/jso
n' -d @ml.json"
muleLoginJSON=$(eval $muleLogin)
accessToken=$(echo $muleLoginJSON | jq -r '.access_token')
echo $accessToken

environmentIds="<your_anypointplatform_environment_id>"
organizationId="<your_anypointplatform_organization_id>"

total=0
currentDate=`date +"%Y-%m-%d %T"`
echo Current date is: ${currentDate}
startDate="2021-07-30 14:59:43"
echo $startDate
while :
do
                queryJSON='{"startDate": "'$startDate'","endDate": "'$currentDate'","platforms": ["Runtime Manager"],"environmentIds": ["
'$environmentIds'"],"objectTypes":["Application"],"ascending": false,"organizationId":"'$organizationId'","offset": 0,"limit": 25}'
                #echo "[INFO]$queryJSON"
        audit="curl --silent --location --request POST 'https://anypoint.mulesoft.com/audit/v2/organizations/$organizationId/query' --hea
der 'Authorization: Bearer $accessToken' --header 'Content-Type: application/json' -d '$queryJSON'"
        auditJSON=$(eval $audit)
        echo "#########################################"
        echo $auditJSON
                totalJSON=$(echo $auditJSON | jq -r '.total')
                echo "TOTAL $totalJSON"
                if [ $totalJSON -gt $total ]
                then
                        echo $auditJSON  > /dev/udp/yourUDP_server/yourUDP_port
                else
                        echo '[INFO] No hay eventos de auditoria.'
                fi
        sleep 5
                startDate=$currentDate
                currentDate=`date +"%Y-%m-%d %T"`
                echo "[INFO] StartDate $startDate"
                echo "[INFO] EndDate $currentDate"
done
