#!/bin/bash

url=$(./extractURLfromPage "$1")

if [ -z "$url" ]; then
    echo "Failed to retrieve the URL from the Go script."
    exit 1
fi

maindir="$(pwd)"
cachedir="$maindir/cache"
serverdir="$maindir/server"
safefiles="allowlist.json config development_behavior_packs development_resource_packs permissions.json server.properties worlds"
missing_count=0

if [ ! "$url" ]; then
    echo "Missing the URL for the first argument!"
    exit 1
fi

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
rm -rf "$serverdir/*"

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
