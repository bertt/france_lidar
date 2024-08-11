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

https://flatgeobuf.blob.core.windows.net/fgb/france_lidar_tiles.fgb

To run:

```shell
chmod +x process_footprints.sh
./process_footprints.sh
```

## Viewer

Viewer index.html has two parts:

- Left: MapBox footprint viewer

Gets and draws footprints from france_lidar_TILES.FGB

Onclick on a footpint, the COPC viewer with the corresponding url is filled 

- Right: COPC Viewer

Live demo see: https://bertt.github.io/france_lidar/