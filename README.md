# docker-zcashd

Zcashd v2.0.0: [https://github.com/zcash/zcash/releases/tag/v2.0.0](https://github.com/zcash/zcash/releases/tag/v2.0.0)

## Usage

### Build the image

> docker build -t zcashd .

### Run example

> docker run -it -v /home/user/.zcash-params:/home/zcashd/.zcash-params -e "ZCASHD_ARGUMENTS=-conf" zcashd

**NB**. Make sure to mount `.zcash-params` in `/home/zcashd/.zcash-params`. You can download it with: `wget -qO- https://github.com/zcash/zcash/blob/master/zcutil/fetch-params.sh | bash`
