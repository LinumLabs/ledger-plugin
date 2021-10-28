#!/bin/bash

# FILL THESE WITH YOUR OWN SDKs PATHS and APP-ETHEREUM's ROOT
NANOS_SDK=""
NANOX_SDK=""
APP_ETHEREUM="plugin_dev/app-ethereum"

# list of apps required by tests that we want to build here
appnames=("ethereum" "ethereum_classic")

# create elfs folder if it doesn't exist
mkdir -p elfs

# move to repo's root to build apps
cd ..

echo "*Building elfs for Nano S..."

echo "**Building app-lido for Nano S..."
make clean BOLOS_SDK=$NANOS_SDK
make -j DEBUG=1 BOLOS_SDK=$NANOS_SDK
cp "${APP_ETHEREUM}/bin/app.elf"  "tests/elfs/compound_nanos.elf"

echo "**Building app-ethereum for Nano S..."
cd $APP_ETHEREUM
make clean BOLOS_SDK=$NANOS_SDK
make -j DEBUG=1 ALLOW_DATA=1 BOLOS_SDK=$NANOS_SDK CHAIN=ethereum
cd -
cp "${APP_ETHEREUM}/bin/app.elf" "tests/elfs/ethereum_nanos.elf"


echo "*Building elfs for Nano X..."

echo "**Building app-lido for Nano X..."
make clean BOLOS_SDK=$NANOX_SDK
make -j DEBUG=1 BOLOS_SDK=$NANOX_SDK
cp "${APP_ETHEREUM}/bin/app.elf"  "tests/elfs/compound_nanox.elf"

echo "**Building app-ethereum for Nano X..."
cd $APP_ETHEREUM
make clean BOLOS_SDK=$NANOX_SDK
make -j DEBUG=1 ALLOW_DATA=1 BOLOS_SDK=$NANOX_SDK CHAIN=ethereum
cd -
 cp "${APP_ETHEREUM}/bin/app.elf" "tests/elfs/ethereum_nanox.elf"

echo "done"
