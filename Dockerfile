FROM ubuntu:18.04

COPY ./ /root/HElib/

RUN apt update && \
    apt install -y build-essential wget cmake m4 libgmp-dev file && \
    cd ~ && \
    wget https://www.shoup.net/ntl/ntl-11.3.2.tar.gz && \
    tar xf ntl-11.3.2.tar.gz && \
    cd ntl-11.3.2/src && \
    ./configure SHARED=on NTL_GMP_LIP=on NTL_THREADS=on NTL_THREAD_BOOST=on && \
    make -j4 && \
    make install && \
    cd ~ && \
    mkdir HElib/build && \
    cd HElib/build && \
    cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_SHARED=ON -DENABLE_THREADS=ON .. && \
    make -j4 && \
    make install && \
    ldconfig

