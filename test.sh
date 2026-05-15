#!/bin/bash

# WARNING: This will remove all local changes!
rm -rf .repo/local_manifests
rm -rf kernel/sony
rm -rf device/sony
rm -rf hardware/sony
rm -rf vendor/sony
rm -rf vendor/lineage-priv

# Initialize repo
repo init -u https://github.com/crdroidandroid/android.git -b 16.0 --git-lfs --no-clone-bundle

# Sync the repositories
/opt/crave/resync.sh
repo sync

# Clone device tree
git clone https://github.com/aoitsme/stardust_kernel_sony_sdm845 -b bpf kernel/sony/sdm845
git clone https://github.com/aoitsme/android_device_sony_aurora -b lineage-23.2 device/sony/aurora
git clone https://github.com/aoitsme/android_device_sony_tama-common -b crdroid-16.0 device/sony/tama-common
git clone https://github.com/aoitsme/android_hardware_sony_SonyOpenTelephony -b lineage-23.2 hardware/sony/SonyOpenTelephony
git clone https://github.com/aoitsme/proprietary_vendor_sony_aurora -b lineage-23.2 vendor/sony/aurora
git clone https://github.com/aoitsme/proprietary_vendor_sony_tama-common -b lineage-23.2 vendor/sony/tama-common
git clone https://github.com/aoitsme/keys -b master vendor/lineage-priv

# Set up build environment
. build/envsetup.sh

# Build rom
brunch aurora
