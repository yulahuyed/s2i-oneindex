## codecasts/s2i-caddy-fpm7

Openshift s2i image for running Laravel (or other php projects).

- Alpine Linux
- PHP-FPM 7
- Caddy


For custom entry file or another public directory, change the etc/caddy/caddy.conf file to reflect your needs


Build: 
```
make build
```

Release
```
make release
```

Test
```
make test
```

Special thanks to https://github.com/bitwalker/s2i-alpine-base that made the base s2i image with alpine that runs on openshift.

