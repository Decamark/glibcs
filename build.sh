#!/usr/bin/env bash

mkdir -p i386-linux-gnu
mkdir -p x86_64-linux-gnu

git clone git://sourceware.org/git/glibc.git

mkdir -p glibc/build
cd glibc/build

versions=(2.24 2.25 2.26 2.27 2.28 2.29 2.30)

for v in "${versions[@]}"
do
    git checkout origin/release/$v/master

    # 64 bit
    libc_cv_slibdir="/lib64" ../configure --prefix=$(pwd)
    make -j `nproc`
    cp libc.so ../../x86_64-linux-gnu/libc-$v.so
    cp elf/ld.so ../../x86_64-linux-gnu/ld-$v.so

    rm -Rf *

    # 32 bit
    CC="gcc -m32" CFLAGS="-O2 -march=i686" libc_cv_slibdir="/lib" \
      ../configure --prefix=$(pwd) --build=i686-linux-gnu
    make -j `nproc`

    cp libc.so ../../i386-linux-gnu/libc-$v.so
    cp elf/ld.so ../../i386-linux-gnu/ld-$v.so

    rm -Rf *
done
