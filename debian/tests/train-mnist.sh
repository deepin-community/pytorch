#!/bin/sh
set -e

# prepare directory and dataset
mkdir -p data/FashionMNIST/raw/
cp -v /usr/share/datasets/fashion-mnist/* data/FashionMNIST/raw/
cd data/FashionMNIST/raw/; gzip -d *.gz; cd -

# train
python3 debian/tests/train-mnist.py
