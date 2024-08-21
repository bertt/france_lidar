# France LIDAR files viewer

Processing script and basic viewer for France LIDAR copc files

Live demo see: https://bertt.github.io/france_lidar/

## Process big footprints

The big footprints are the areas containing COPC files. They are copied from a WFS and converted to GeoJSON (file bluetiles_4326.geojson)

To get them:

```
$ wget -O bluetiles_4326.geojson "https://data.geopf.fr/private/wfs/?service=WFS&version=2.0.0&apikey=interface_catalogue&request=GetFeature&typeNames=IGNF_LIDAR-HD_TA:nuage-bloc&outputFormat=application/json&SRSNAME=EPSG:4326"
```

## Process small footprints

Script 'process_footprints.sh' does the following actions:

- Download geojson footprints per page (5000 footprints) from WFS;

- Combine all geojson files using geojson_merge

- Convert combined geojson file to FlatGeobuf file


Prerequisites:

- Node.JS

- geojson-merge

- ogr2ogr

Result script: france_lidar_tiles.fgb

Online url:

https://bertt.github.io/france_lidar_catalog/france_lidar_tiles.fgb

To run:

```shell
chmod +x process_footprints.sh
./process_footprints.sh
```

Sample GDAL query on flatgeobuf:

```shell
ogrinfo /vsicurl/https://bertt.github.io/france_lidar_catalog/france_lidar_tiles.fgb -sql "SELECT url FROM france_lidar_tiles limit 10"
```

## Viewer

Viewer index.html has two parts:

- Left: Leaflet big footprints viewer

Gets and draws footprints from bluetiles_4326.geojson

Onclick on a footprint, the flatgeobuf file is requested (with parameters click location) to get the polygon and url of the COPC 

The small footprint is drawn in red

the COPC viewer with the corresponding url is filled 

- Right: COPC Viewer
