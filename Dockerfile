FROM lganzzzo/alpine-cmake:latest

# Install dependencies for building CMake
RUN apk add --no-cache wget build-base

# Download and extract the CMake source code
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.1/cmake-3.22.1.tar.gz && \
    tar -zxvf cmake-3.22.1.tar.gz && \
    cd cmake-3.22.1 && \
    ./bootstrap && \
    make && \
    make install && \
    cd .. && \
    rm -rf cmake-3.22.1.tar.gz cmake-3.22.1

ADD . /service

WORKDIR /service/utility

RUN ./install-oatpp-modules.sh

WORKDIR /service/build

RUN cmake ..
RUN make

EXPOSE 8000 8000

ENTRYPOINT ["./my-project-exe"]
