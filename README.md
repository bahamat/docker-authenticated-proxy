# User Authenticating HTTP Proxy

This docker image creates a quick and simple user authenticating HTTP proxy.

## Usage

To use the example username/password:

    docker run -d -p 8080:80 bahamat/authenticated-proxy

To override the htpasswd file:

    docker run -d -v ${PWD}/htpasswd:/etc/apache2/htpasswd -p 8080:80 bahamat/authenticated-proxy

## Authentication

This image uses HTTP basic auth.

* The default user is `jack`
* The default pass is `insecure`

To create an override `htpasswd` file with an initial user:

    htpasswd -c -b htpasswd walter wh4tsmyname

To add additional users:

    htpasswd -b htpasswd skylar h0lly

You can also use `docker exec` to reinitialize the `htpasswd` file in the running container:

    docker exec kickass_heisenberg htpasswd -c -b /etc/apache2/htpasswd walter wh4tsmyname

Or use `docker exec` to create additional users:

    docker exec kickass_heisenberg htpasswd -b /etc/apache2/htpasswd skylar h0lly
