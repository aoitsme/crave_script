#!/bin/bash

# WARNING: This will remove all local changes!
rm -rf .repo/local_manifests
rm -rf frameworks/native
rm -rf hardware/interfaces
rm -rf kernel/sony
rm -rf device/sony
rm -rf hardware/sony
rm -rf vendor/sony
rm -rf vendor/lineage-priv

# Initialize repo
repo init -u https://github.com/AxionAOSP/android.git -b lineage-23.2 --git-lfs

# Sync the repositories
/opt/crave/resync.sh
repo sync

# Replace some repo
rm -rf frameworks/native
rm -rf hardware/interfaces
git clone https://github.com/aoitsme/android_frameworks_native -b axion-23.2 frameworks/native
git clone https://github.com/aoitsme/android_hardware_interfaces -b axion-23.2 hardware/interfaces

# Clone device tree
git clone https://github.com/aoitsme/android_kernel_sony_sdm845 -b bpf kernel/sony/sdm845
git clone https://github.com/aoitsme/android_device_sony_aurora -b axion-23.2 device/sony/aurora
git clone https://github.com/aoitsme/android_device_sony_tama-common -b axion-23.2 device/sony/tama-common
git clone https://github.com/aoitsme/android_hardware_sony_SonyOpenTelephony -b lineage-23.2 hardware/sony/SonyOpenTelephony
git clone https://github.com/aoitsme/proprietary_vendor_sony_aurora -b lineage-23.2 vendor/sony/aurora
git clone https://github.com/aoitsme/proprietary_vendor_sony_tama-common -b lineage-23.2 vendor/sony/tama-common
git clone https://github.com/aoitsme/keys -b master vendor/lineage-priv

# Set up build environment
. build/envsetup.sh

# Build rom
axion aurora va
ax -br -j$(nproc --all)
