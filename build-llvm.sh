#!/bin/bash -
#===============================================================================
#
#          FILE: build-llvm.sh
#        AUTHOR: Peng Wang
#         EMAIL: pw2191195@gmail.com
#       CREATED: 09/02/17 22:52:05
#         USAGE: ./build-llvm.sh
#   DESCRIPTION: 
#===============================================================================


set -o nounset                         # Treat unset variables as an error

LLVM_VERSION="4.0.1"
SITE="http://releases.llvm.org/${LLVM_VERSION}"
CPUS=`cat /proc/cpuinfo  | grep -c processor`

rm -rf tmp/
mkdir -p tmp/build
mkdir -p download

#wget "${SITE}/llvm-${LLVM_VERSION}.src.tar.xz" -P download/
#wget "${SITE}/cfe-${LLVM_VERSION}.src.tar.xz" -P download/
#wget "${SITE}/compiler-rt-${LLVM_VERSION}.src.tar.xz" -P download/
#wget "${SITE}/clang-tools-extra-${LLVM_VERSION}.src.tar.xz" -P download/

tar -ax -f download/llvm-${LLVM_VERSION}.src.tar.xz -C tmp/
tar -ax -f download/cfe-${LLVM_VERSION}.src.tar.xz -C tmp/
tar -ax -f download/compiler-rt-${LLVM_VERSION}.src.tar.xz -C tmp/
tar -ax -f download/clang-tools-extra-${LLVM_VERSION}.src.tar.xz -C tmp/

mv tmp/llvm-${LLVM_VERSION}.src tmp/llvm
mv tmp/cfe-${LLVM_VERSION}.src tmp/llvm/tools/clang
mv tmp/compiler-rt-${LLVM_VERSION}.src tmp/llvm/projects/compiler-rt
mv tmp/clang-tools-extra-${LLVM_VERSION}.src tmp/llvm/tools/clang/tools/extra

cd tmp/build
cmake ../llvm -DCMAKE_BUILD_TYPE=release -DDLLVM_TARGETS_TO_BUILD="x86_64"
make -j ${CPUS}
