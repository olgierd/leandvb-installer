#!/bin/bash

# installer for leandvb 

# fetch and build leandvb
git clone -b work http://github.com/pabr/leansdr.git
cd leansdr/src/apps

# uncommend LEANSDR_EXTENSIONS
sed -i "s/#\(CXXFLAGS.\+LEANSDR_EXT.\+\)/\1/g" Makefile

# build
make
cd ../../..

# run functional test
cd leansdr/test
make leandvb-ft
cd ../..

# fetch and build LDPC decoder
git clone -b ldpc_tool http://github.com/pabr/xdsopl-LDPC-pabr
cd xdsopl-LDPC-pabr
make CXX=g++ ldpc_tool
cd ..

# copy ldpc_tool
cp xdsopl-LDPC-pabr/ldpc_tool leansdr/test/
cp xdsopl-LDPC-pabr/ldpc_tool leansdr/src/apps/

# run SND tests
cd leansdr/test
make leandvb-snr
cd ../..
