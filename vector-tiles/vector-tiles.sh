#!/bin/bash

#brew install node
#brew install tippecanoe
#npm install osmium
#npm install turf
#npm install mapbox-upload

echo
echo reading pbf file and writing hdm features to json
echo

node process.js $@


echo
echo generating file.mbtile from hdm-data/*.json with tippecanoe
echo

tippecanoe \
  -z 14 -Z 13 \
  -d12 -D12 \
  -b 20 \
  -pc -f \
  -o hdm.mbtiles \
    hdm-data/hdm_label.json\
    hdm-data/water_source.json \
    hdm-data/communication.json \
    hdm-data/electric_utility.json \
    hdm-data/sanitation.json \
    hdm-data/emergency.json \
    hdm-data/medical.json \
    hdm-data/building_condition.json \
    hdm-data/road_condition.json \
    hdm-data/site.json


# upload the mbtiles to Mapbox.com
echo 
node upload.js
