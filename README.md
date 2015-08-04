# Humanitarian Style for Mapbox Studio

All about high contrast and printability; a Mapbox Studio style designed for humanitarian response that uses a humanitarian data model vector tiles source.

1. [About the style](/README.md#about-the-style)
2. Roll your own HDM vector tiles
3. Generate print maps and download image MBTiles

## About the style

This is about the design.

## Roll your own HDM vector tiles

This is how you would generate HDM tiles from a .pbf and then upload them to Mapbox.

### Dependencies for Mac OS X:

- **node** version 010 : `$ brew install https://raw.githubusercontent.com/Homebrew/homebrew-versions/master/node010.rb `
- **fs** : `$ npm install fs`
- **node-osmium** : `$ npm install osmium`
- **turf** : `$ npm install turf`

### Generating Vector MBTiles

After running `./process.js`, if you want to create a vector MBTiles file, install **tippecanoe** with

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

## Generate print maps and download image MBTiles

Use Mapbox Studio's export functionality and tl to create map products suitable for offline use.