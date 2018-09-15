# docker-zcashd

Zcashd: [https://github.com/zcash/zcash](https://github.com/zcash/zcash)

Image location: [https://quay.io/repository/exodusmovement/zcashd](https://quay.io/repository/exodusmovement/zcashd)

Every new zcashd release have own branch where branch name is zcashd version. For each docker image release we create tag `BRANCH_NAME-xxx`, where `xxx` is release version for *current* branch. Docker image with latest tag is used only for development and contain last build (please do not use it for production!).

Branches and releases:

 - [2.0.0](https://github.com/ExodusMovement/docker-zcashd/tree/2.0.0)
   - [2.0.0-001](https://github.com/ExodusMovement/docker-zcashd/tree/2.0.0-001)
   - [2.0.0-002](https://github.com/ExodusMovement/docker-zcashd/tree/2.0.0-002)

## Usage

### Build the image

> docker build -t zcashd .

### Run example

> docker run -it -v $(pwd)/zcash-params:/home/zcashd/.zcash-params -e "ZCASHD_ARGUMENTS=-conf" zcashd

Make sure to mount `.zcash-params` in `/home/zcashd/.zcash-params`.\
You can download it with: `docker run -it --rm -v $(pwd)/zcash-params:/home/zcashd/.zcash-params zcashd zcashd-fetch-params`
