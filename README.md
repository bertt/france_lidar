# France LIDAR files viewer

Processing script and basic viewer for France LIDAR copc files

## Script

Script does the following actions:

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

- Left: MapBox footprint viewer

Gets and draws footprints from france_lidar_TILES.FGB

Onclick on a footpint, the COPC viewer with the corresponding url is filled 

- Right: COPC Viewer

Live demo see: https://bertt.github.io/france_lidar/