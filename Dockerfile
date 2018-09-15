FROM ubuntu:18.04 as builder

ENV BUILD_TAG 2.0.0

RUN apt update
RUN apt install -y \
  autoconf \
  build-essential \
  pkg-config \
  libc6-dev \
  m4 \
  g++-multilib \
  libtool \
  ncurses-dev \
  unzip \
  python \
  zlib1g-dev \
  bsdmainutils \
  automake \
  wget \
  curl

RUN wget -qO- https://github.com/zcash/zcash/archive/v$BUILD_TAG.tar.gz | tar xz && mv /zcash-$BUILD_TAG /zcash
WORKDIR /zcash

RUN ./zcutil/build.sh --disable-tests --disable-mining -j$(nproc)
RUN strip /zcash/src/zcashd /zcash/src/zcash-cli


FROM ubuntu:18.04

RUN apt update \
  && apt install -y \
    libgomp1 \
    wget \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /zcash/src/zcashd /zcash/src/zcash-cli /usr/local/bin/
COPY ./fetch-params.sh /usr/local/bin/zcashd-fetch-params

RUN groupadd --gid 1000 zcashd \
  && useradd --uid 1000 --gid zcashd --shell /bin/bash --create-home zcashd

USER zcashd

# P2P & RPC
EXPOSE 8233 8232

ENV \
  ZCASHD_DBCACHE=450 \
  ZCASHD_PAR=0 \
  ZCASHD_PORT=8233 \
  ZCASHD_RPC_PORT=8232 \
  ZCASHD_RPC_THREADS=4 \
  ZCASHD_ARGUMENTS=""

CMD exec zcashd \
  -dbcache=$ZCASHD_DBCACHE \
  -par=$ZCASHD_PAR \
  -port=$ZCASHD_PORT \
  -rpcport=$ZCASHD_RPC_PORT \
  -rpcthreads=$ZCASHD_RPC_THREADS \
  $ZCASHD_ARGUMENTS
