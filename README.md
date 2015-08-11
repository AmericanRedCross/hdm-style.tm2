NOTE: *still under heavy development*

# Humanitarian Style for Mapbox Studio

All about high contrast and printability; a Mapbox Studio style designed for humanitarian response that uses a humanitarian data model vector tiles source.

This style and the workflow for generating HDM vector tiles is largely inspired by https://github.com/osmlab/mapbox-studio-humanitarian-print.tm2

1. [About the style](README.md#about-the-style)
2. [Create your own HDM vector tiles](README.md#create-your-own-hdm-vector-tiles)
3. [Generate print maps and download image MBTiles](README.md#generate-print-maps-and-download-image-mbtiles)

## About the style

The map is designed for print. High contrast and patterns make the map safe for printers of any quality.

The Humanitarian Data Model (HDM) used for this map pulls specific OpenStreetMap (OSM) tags from `osm.pbf` files to provide important humanitarian information that supplements the Mapbox data platform.

Using [Mapbox Terrain and Mapbox Streets](https://www.mapbox.com/data-platform/) vector tile layers provides topgraphic and landcover context for the entire world and constantly updates with roads, buildings, POIs, and more from the OpenStreetMap database.

<img width="1208" alt="screen shot 2015-08-04 at 12 17 16 pm" src="https://cloud.githubusercontent.com/assets/8019997/9067433/6470c110-3aab-11e5-873c-fd19f9b13146.png">
<img width="1116" alt="screen shot 2015-08-04 at 12 23 49 pm" src="https://cloud.githubusercontent.com/assets/8019997/9067436/68a80234-3aab-11e5-8f6f-aea036631b8a.png">
<img width="1112" alt="screen shot 2015-08-04 at 12 24 46 pm" src="https://cloud.githubusercontent.com/assets/8019997/9067439/6b993bca-3aab-11e5-8e1b-3a2a9bdfd66b.png">
<img width="1034" alt="screen shot 2015-08-04 at 12 29 52 pm" src="https://cloud.githubusercontent.com/assets/8019997/9067440/6e971860-3aab-11e5-9294-05bd986b02b2.png">

## Create your own HDM vector tiles

*You can find the scripts for the processing described below in [/vector-tiles/](/vector-tiles/)*

Currently, this Mapbox Studio style pulls from HDM vector tiles that cover OSM data for Kathmandu, Central America, and the Philippines.

Follow these steps to use this Mapbox Studio style and to generate vector tiles for your area of interest.

1. Install dependencies
2. Use the included node-osmium script to generate collections of HDM GeoJSON data from an `osm.pbf` file.
3. Use Tippecanoe to generate vector MBTiles from HDM GeoJSON data.
4. Upload vector MBTiles to Mapbox.

### Dependencies for Mac OS X:

- **node** version 010 : `$ brew install https://raw.githubusercontent.com/Homebrew/homebrew-versions/master/node010.rb `
- **fs** : `$ npm install fs`
- **node-osmium** : `$ npm install osmium`
- **turf** : `$ npm install turf`

### Generating Vector MBTiles

First, download an `osm.pbf` file for your region of interest. http://download.geofabrik.de/ provides daily region and country abstracts.

Then run `$ node ./process.js ./your-region-latest.osm.pbf`. Add as many `osm.pbf` as you wish to that command for mapping multiple regions.

After running `./process.js`, if you want to create a vector MBTiles file, install [**tippecanoe**](https://www.github.com/mapbox/tippecanoe/) with

```
brew install tippecanoe
```
then do
```
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
```

You can adjust the `hdm.json` file to create different data models for your vector tiles. In the **Tippecanoe** command above, each `hdm-data/file.json` is a layer that gets added to the MBTiles. If you create different layers in `hdm.json`, you'll have to update the file names in the **Tippecanoe** command above.

### Uploading to Mapbox

You can manually upload the output `hdm.mbtiles` file from your **Tippecanoe** command to Mapbox's data hosting services here: https://www.mapbox.com/uploads/?source=data

You can also use the script below to upload the `hdm.mbtiles` file. You'll need to
1. Install the **mapbox-upload** dependency : `$ npm install mapbox --save mapbox-upload`
2. Change the third line, adding in  your own Mapbox access token with an `uploads:write` scope. Create one of those tokens at https://www.mapbox.com/account/apps/
4. Change the 4th line to your Mapox user account

```
#!/usr/bin/env node

var mapboxAccessToken = '<your-mapbox-token-with-uploads:write-scope>'; // create a token here --> https://www.mapbox.com/account/apps/
var mapboxUserAccount = '<your-mapbox-account-user-name-here>';

var upload = require('mapbox-upload');

console.log('Starting upload.');

var progress = upload({
    file: __dirname + '/hdm.mbtiles',
    account: mapboxUserAccount,
    accesstoken: mapboxAccessToken,
    mapid: mapboxUserAccount + '.' + 'humanitarian-data-model'
});

progress.on('error', function(err){
    if (err) throw err;
});

progress.on('progress', function(p){
  process.stdout.write(Math.round(p.percentage,4) + "%\r");
})

progress.once('finished', function(){
    console.log("Tiles are processing at Mapbox.com");
});
```

Save this script above, updated with your access token, into a file `upload.js`, then run `$ chmod u+rwx ./upload.js` and then `$ ./upload.js`.

You can change the `mapid`, the identifier where your vector tiles are uploaded to, by switching out where it says `'humanitarian-data-model'` on line 9 for some other valid `mapid` (like a short string of text, no spaces). 

A writeup on how a constantly updating global HDM vector tiles source might be created is available [here](https://gist.github.com/aaronpdennis/0c658c543f5340236bba).

## Generate print maps and download image MBTiles

Use Mapbox Studio's export functionality and tl to create map products suitable for offline use.

### Creating image MBTiles from this Mapbox Studio style.

Install [tl](https://github.com/mojodna/tl).

`npm install tl mbtiles tilelive-http tilelive tilejson`

Adjust your bounding box `-b` (WSEN), min zoom `-z`, and max zoom `-Z` to your area.

```
tl copy 
  -z 6 -Z 8 -b "-124.4096 32.5343 -114.1308 42.0095" \
  tmstyle://./hdm-style.tm2/ mbtiles://./tiles.mbtiles
```

This will output an MBTiles file that contains static PNG map tiles. You can upload this MBTiles file to Mapbox's hosting services at https://www.mapbox.com/uploads/.
