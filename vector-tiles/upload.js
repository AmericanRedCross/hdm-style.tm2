#!/usr/bin/env node

var upload = require('mapbox-upload');

console.log('Starting upload.');

var progress = upload({
    file: __dirname + '/hdm.mbtiles',
    account: 'aarondennis',
    accesstoken: '<your-upload-token-here',
    mapid: 'aarondennis.humanitarian-data-model-v1'
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
