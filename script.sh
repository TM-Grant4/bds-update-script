#!/bin/bash

set -e

SERVER_URL="https://www.minecraft.net/en-us/download/server/bedrock"
declare -A indexes
indexes[win]=1
indexes[ubuntu]=2
indexes[win_preview]=3
indexes[ubuntu_preview]=4

if [ $# -lt 1 ]; then
    echo "Usage: $0 [win|ubuntu|win_preview|ubuntu_preview]"
    exit 1
fi

type="$1"
index="${indexes[$type]}"

if [ -z "$index" ]; then
    echo "Invalid type: $type"
    exit 1
fi

html=$(curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" "$SERVER_URL")
url=$(echo "$html" | grep -oP 'href="\Khttps://www.minecraft.net/bedrockdedicatedserver/[^"]+' | sed -n "${index}p")

if [ -z "$url" ]; then
    echo "Failed to retrieve the URL."
    exit 1
fi


maindir="$(pwd)"
cachedir="$maindir/cache"
serverdir="$maindir/server"
safefiles="allowlist.json config development_behavior_packs development_resource_packs permissions.json server.properties worlds"
missing_count=0

if [ ! -d "$serverdir" ]; then
    echo "Server folder does not exist!"
    exit 1
fi

for item in $safefiles; do
    if [ ! -e "$serverdir/$item" ]; then
        echo "$item - Not Found!"
        missing_count=$((missing_count + 1))
    fi
done

if [ "$missing_count" -gt 0 ]; then
    echo -n "$missing_count (file/dir)s are not found! Would you like to continue? (Y/N) "
    read -n1 -s answer

    if [[ "$answer" == [Nn] ]]; then
        exit 0
    else
        echo -e "\nIgnoring missing files..."
    fi
fi

mkdir -p "$cachedir"

for item in $safefiles; do
    if [ -e "$serverdir/$item" ]; then
        echo "Backing up $item..."
        cp -ri "$serverdir/$item" "$cachedir/" || exit 1
    fi
done

echo "Removing old files in $serverdir"
rm -rf "$serverdir"/*

echo "Downloading $url"
wget -O "$serverdir/server.zip" --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:122.0) Gecko/20100101 Firefox/122.0" "$url"

echo "Extracting server zip file..."
unzip -q "$serverdir/server.zip" -d "$serverdir/"
rm "$serverdir/server.zip"

echo "Copying saved files back into $serverdir"
cp -ri "$cachedir"/* "$serverdir/"

echo "Removing cache directory..."
rm -rf "$cachedir"

echo "Update complete!"
exit 0
