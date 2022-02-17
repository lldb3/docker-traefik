# Docker Compose Traefik Setup

## Intro

This repo contains some template work for a simple to more advanced config using traefik as a reverse proxy with docker, then adding services as needed. The goal is to have some good templates for quick deployments that don't sacrifice (too much) security.

The configuration is provided as an example, it originated from [this work](https://www.smarthomebeginner.com/traefik-2-docker-tutorial/#Traefik_2_Configuration), repo available [here](https://github.com/htpcBeginner/docker-traefik).

### Directory structure

* `appdata` - contains all info that is not suppose to be shared: 
    - Custom configs with sensitive secrets
    - Databases
    - Etc
* `config` - config files that can be made public
* `secrets` - our docker-compose secrets
* `scripts` - a set of custom scripts that should be run to help configuration in some cases

## Quick Launch

### DNS Challenge

The first thing to do in order to get this working, is to have a domain, and perform the DNS validation step to get a valid Certificate.
#### A+ Certification from SslLabs.com

In order to stay compliant with latest security recommendations, we should change the TLS options applied to our entrypoint (*websecure*). The exact configuration is available in the [tls-opts.yml file](./config/traefik2/rules/tls-opts.yml).

Moreover, once a valid certificate is obtained for your server, you should add a [CAA Record](https://letsencrypt.org/docs/caa/) to your DNS.

***Note: *** These recommendations change over time, see [Mozilla's awesome configurator](https://ssl-config.mozilla.org/) for updates.

### Authentication

#### Basic Auth

To generate an htpasswd, use the `htpasswd` util from `apache-utils` package.
Put the hash in an `.htpasswd` file in the `shared` directory, or as a secret.

**Note:** if you use the docker-compose file to pass the password hash, you should escape the `$` signs with `$$`. You can do that in a single oneliner: `echo $(htpasswd -nb username mystrongpassword) | sed -e s/\\$/\\$\\$/g`,

#### 2FA - Two Factor Authentication


## Service Notes

### Nextcloud

Does not work properly until we change the `config.php` file with bellow options

```php
'overwriteprotocol' => 'https',
'overwrite.cli.url' => 'https://NEXTCLOUDDOMAIN',

```
### Restic Rest-server

NB: add `.htpasswd` in rest-server folder in order to use authentication, or specify the `--no-auth` flag in OPTIONS.
Test the config using the restic client as such: `restic -r rest:https://user:pass@restic.$DOMAINNAME:443/user init`. The user and pass should be configured, and the '443' option can be ommited as the `https` option provides the value.

For **TLS**, it is not needed as traefik handles it for you.

## TODOs

- Use a custom config file for redis-server
- Change the defaults on the socket-proxy
- Change defaul HTTP headers for nextcloud in order to solve "X-Forwarded-For" issues
- Harden nextcloud: https://docs.nextcloud.com/server/latest/admin_manual/installation/harden_server.html 
- More nextcloud config to remove .caldav warnings
- Documentation and deployment of other auth systems (2FA, authelia)
- GitLab 

### Need attention

```
# redis
vm.overcommit_memory = 1' to /etc/sysctl.conf
```