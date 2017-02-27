#!/bin/bash
# Read data from Influx and post them via mosquitto_pub into MQTT
# TODO: make me sexy

# read Data
for i in `seq 2 5`;
do
  values=`curl -sS -G 'http://localhost:8086/query' --data-urlencode "db=f007th" --data-urlencode "q=SELECT \"value\" FROM \"temperature\"  where time > now() - 3h AND channel = '$i' ORDER BY time DESC limit 1" | jq '.results[0].series[0].values[0]'`
  mosquitto_pub -d -h localhost -p 1883 -r -m "$values" -t "f007th/$i/temperature"

  values=`curl -sS -G 'http://localhost:8086/query' --data-urlencode "db=f007th" --data-urlencode "q=SELECT \"value\" FROM \"humidity\"  where time > now() - 3h AND channel = '$i' ORDER BY time DESC limit 1" | jq '.results[0].series[0].values[0]'`
  mosquitto_pub -d -h localhost -p 1883 -r -m "$values" -t "f007th/$i/humidity"
done
