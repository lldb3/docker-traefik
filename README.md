# Traefik Custom Setup

## Intro

This repo contains some template work for a simple to more advanced config using traefik as a reverse proxy with docker, then adding services as needed.

The configuration is provided as an example, and is derived from [this work](https://www.smarthomebeginner.com/traefik-2-docker-tutorial/#Traefik_2_Configuration), repo available [here](https://github.com/htpcBeginner/docker-traefik).


### Directory structure

* traefik2 - contains all info for the traefik config
* one directory for each service (e.g: portainer, nextcloud, etc)

#### Dir must be created / populated
* shared - folder is used to store shared info between services
* secrets - use to store docker secrets
* see the .gitignore for some I may have forgotten

### Basic Auth

To generate an htpasswd, use the `htpasswd` util from `apache-utils` package.
Put the hash in an `.htpasswd` file in the `shared` directory, or as a secret.

**Note:** if you use the docker-compose file to pass the password hash, you should escape the `$` signs with `$$`. You can do that in a single oneliner: `echo $(htpasswd -nb username mystrongpassword) | sed -e s/\\$/\\$\\$/g`,


#### Security Headers as Labels

/TODO

#### Restic Rest-server

Test the config using the restic client as such: `restic -r rest:https://user:pass@restic.$DOMAINNAME:443/user init`. The user and pass should be configured, and the '443' option can be ommited as the `https` option provides the value.

For **TLS**, it is not needed as trefik handles it for you.

