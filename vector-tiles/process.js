#!/usr/bin/env node

var fs = require('fs');
var osmium = require('osmium');
var turf = require('turf');

var location_handler = new osmium.LocationHandler();
var handler = new osmium.Handler();

var hdm = JSON.parse(fs.readFileSync('hdm.json', 'utf8'));

var hdmTags = [];
var hdmClasses = [];
var hdmLayers = [];

var tagClassAndLayer = {};
var hdmClassLayer = {};

function findPropertyFromTag(tag, layer) {
  for (var property in hdm[layer]) {
    if (hdm[layer].hasOwnProperty(property) && property !== "class") {
      for (value in hdm[layer][property]) {
        if (hdm[layer][property].hasOwnProperty(value)) {
          for (var i = 0; i < hdm[layer][property][value].length; i++) {
            if (hdm[layer][property][value].indexOf(tag) > -1) {
              return { "property" : property, "value" : value };
            }
          }
        }
      }
    }
  }
}

console.log('');

tagsCounter = 0;

for (var layer in hdm) {
  if (hdm.hasOwnProperty(layer)) {
    hdmLayers.push(layer);
    for (classAttr in hdm[layer]["class"]) {
      if (hdm[layer]["class"].hasOwnProperty(classAttr)) {
        hdmClasses.push(classAttr);
        for (var i = 0; i < hdm[layer]["class"][classAttr].length; i++) {
          var osmTag = hdm[layer]["class"][classAttr][i];
          hdmTags.push(osmTag);
          tagsCounter++;
          process.stdout.write(osmTag + ' • ');
          tagClassAndLayer[osmTag] = { "class": classAttr, "layer": layer };
        }
      }
    }
  }
}

console.log('');
console.log(tagsCounter);
console.log('');

handler.options({ 'tagged_nodes_only' : true });

handler.on('node', filter);
handler.on('way', filter);

var dir = './hdm-data';
if (!fs.existsSync(dir)){
    fs.mkdirSync(dir);
}

var wstreams = {};
for (var i = 0; i < hdmLayers.length; i++) {
  wstreams[hdmLayers[i]] = fs.createWriteStream('hdm-data/' + hdmLayers[i] + '.json');
}

var labelWStream = fs.createWriteStream('hdm-data/hdm_label.json');

var counter = 0;

function filter(item) {
  var tags = item.tags();
  var keys = Object.keys(tags);
  keys.forEach(function(key) {
    var candidate = key + '=' + tags[key];

    if ((hdmTags.indexOf(candidate) > -1)) {

      counter++;

      var layer = tagClassAndLayer[candidate].layer;
      var geometry = item.geojson();

      var properties = {};
      properties.class = tagClassAndLayer[candidate].class;

      properties.tag = candidate;

      if (findPropertyFromTag(candidate, layer)) {
        var otherProperties = findPropertyFromTag(candidate, layer);
        properties[otherProperties.property] = otherProperties.value;
      }

      if (keys.indexOf('name' > -1)) {
        properties['name'] = tags['name'];
      }

      if (item.coordinates !== undefined) {
        properties.geom = 'Point';
        properties.osm_id = parseInt(item.id) + Math.pow(10, 15);
      } else if (
        item.geojson().coordinates[0][0] === item.geojson().coordinates[item.geojson().coordinates.length - 1][0] &&
        item.geojson().coordinates[0][1] === item.geojson().coordinates[item.geojson().coordinates.length - 1][1]
      ) {
        properties.geom = 'Polygon';
        properties.osm_id = parseInt(item.id) + Math.pow(10, 12);
      } else {
        properties.geom = 'LineString';
        properties.osm_id = item.id;
      }

      wstreams[layer].write(
        JSON.stringify({
          'type': 'Feature',
          'properties': properties,
          'geometry': item.geojson()
        }) + "\n"
      );

      if (   properties.class !== 'residential'
          && properties.class !== 'common'
          && properties.class !== 'rubble'
          && properties.class !== 'landslide'
          && properties.class !== 'transmission'
          && layer !== 'road_condition')
      {

        var feature = {
          'type': 'Feature',
          'properties': {},
          'geometry': {
            'type': properties.geom,
            'coordinates': properties.geom !== 'Polygon' ? item.geojson().coordinates : [item.geojson().coordinates]
          }
        };

        var labelPt = turf.pointOnSurface(feature);

        labelPt.properties = properties;
        labelPt.properties.layer = layer;
        labelPt.properties.geom = 'Point';
        labelWStream.write(JSON.stringify(labelPt) + '\n');
      }

      process.stdout.write('feature count: ' + counter + '\r');
    }
  });
}

function logFeatureCount() {
  process.stdout.write('feature count: ' + counter + '\n\n');
  counter = 0;
}

for (var i = 2; i < process.argv.length; i++) {

  process.stdout.write(process.argv[i] + '\n');

  file = new osmium.File(process.argv[i], 'pbf');
  reader = new osmium.Reader(file, {
      node: true,
      way: true
  });

  osmium.apply(reader, location_handler, handler);

  logFeatureCount();

}
