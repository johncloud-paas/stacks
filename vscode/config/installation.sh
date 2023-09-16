#!/bin/bash

echo "**** installing python ****"
apt-get install -yqq --no-install-recommends git python3-venv python3-dev python3-pip graphviz libblas-dev liblapack-dev cmake gfortran gcc g++ make libproj-dev proj-data proj-bin libgeos-dev curl
