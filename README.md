[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/bahamat/docker-authenticated-proxy/master/LICENSE)
[![Docker Stars](https://img.shields.io/docker/stars/bahamat/authenticated-proxy.svg?maxAge=2592000)](https://hub.docker.com/r/bahamat/authenticated-proxy/)
[![Docker Pulls](https://img.shields.io/docker/pulls/bahamat/authenticated-proxy.svg?maxAge=2592000)](https://hub.docker.com/r/bahamat/authenticated-proxy/)

# User Authenticating HTTP Proxy

This docker image creates a quick and simple user authenticating HTTP proxy.

## Usage

To use the example username/password:

    docker run -d -p 8080:80 bahamat/authenticated-proxy

To override the htpasswd file:

    docker run -d -v ${PWD}/htpasswd:/etc/htpasswd -p 8080:80 bahamat/authenticated-proxy

### Proxying Traffic

Be warned, authentication does ***not*** go over SSL, so any passwords transmitted should be considered compromised. I.e., don't reuse passwords!

To proxy traffic, point your HTTP client at the exposed endpoint of your docker container.

    http_proxy=http://localhost:8080/ curl -i -U jill:insecure http://www.google.com/

A web browser should be prompted for authentication.

## Authentication

This image uses HTTP basic auth.

* The default user is `jill`
* The default pass is `insecure`

Obviously, using the default configuration on the open Internet is ***not*** advised.

To create an override `htpasswd` file with an initial user:

    htpasswd -B -c -b htpasswd sarah s3stra

To add additional users:

    htpasswd -B -b htpasswd cosima crzysci3ncWU

You can also use `docker exec` to reinitialize the `htpasswd` file in the running container:

    docker exec elusive_manning htpasswd -B -c -b /etc/htpasswd allison 4schoolBrd

Or use `docker exec` to create additional users:

    docker exec elusive_manning htpasswd -B -b /etc/htpasswd helena knifehands
