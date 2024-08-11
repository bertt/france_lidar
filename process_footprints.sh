#!/bin/bash

output_dir="./output"

# create the output directory if it does not exist
if [ ! -d "$output_dir" ]; then
    mkdir "$output_dir"
fi

# empty the output directory on windows
rm -f ${output_dir}/*

base_url="https://data.geopf.fr/private/wfs/?service=WFS&version=2.0.0&apikey=interface_catalogue&request=GetFeature&typeNames=IGNF_LIDAR-HD_TA:nuage-dalle&outputFormat=application/json&count=5000&startIndex="

# download the first 64 pages of the dataset
for page_number in $(seq 1 64); do
    start_index=$((5000 * (page_number - 1)))
    
    url="${base_url}${start_index}"
    output_file="${output_dir}/${page_number}.geojson"
    curl -s "$url" -o "$output_file"
    echo "Page ${page_number} saved in ${output_file}"
    temp_file="${output_dir}/${page_number}_temp.geojson"
    ogr2ogr -f "GeoJSON" -t_srs EPSG:4326 "$temp_file" "$output_file" -s_srs EPSG:2154
    mv "$temp_file" "$output_file"
done

# combine all geojson files into one
echo "Merging all pages into one geojson file..."
files=$(find "${output_dir}" -name "*.geojson")
geojson_file="france_lidar_tiles.geojson"
geojson-merge $files > "${output_dir}/${geojson_file}"

echo "All pages saved in ${output_dir}/${geojson_file}"

# convert to flatgeobuf format
echo "Converting to FlatGeobuf format..."
fgb_file="france_lidar_tiles.fgb"
ogr2ogr -f "FlatGeobuf" "${fgb_file}" "${output_dir}/${geojson_file}"

# remove output directory
rm -rf ${output_dir}/*
rmdir ${output_dir}

echo "FlatGeobuf file saved in ${fgb_file}"
echo "Done"