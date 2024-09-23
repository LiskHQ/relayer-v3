#!/bin/bash
set -eu

app_install_dir=$(dirname $(realpath "$0"))/../../../..

cd ${app_install_dir}

echo "App install dir set to: $PWD"
