# Traefik Custom Setup

## Intro

This repo contains some template work for a simple to more advanced config using traefik as a reverse proxy with docker, then adding services as needed.

The configuration is provided as an example, and is derived from [this work]()


### .htpasswd generation

To generate a `echo $(htpasswd -nb username mystrongpassword) | sed -e s/\\$/\\$\\$/g`, this can then be added eithe in the `shared` directory, or as a secret.

**Note:** it seems there is a bug with basic authentication, using a long password can trigger an issue where the auth prompt will appear every time and not succeed. To prevent this, I've used a password of length 