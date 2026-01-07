#!/bin/bash

~/lilly/PROLEAD/release/PROLEAD \
  -l ~/lilly/PROLEAD/libs/custom.json \
  -n custom \
  -d design.v \
  -m circuit \
  -c config.json \
  2>&1 | tee Report.dat
