# Proxer

Proxer is a simple, dockerized reverse proxy build on nginx.

It autoconfigures itself.

## Usage

I assume that you have working Docker in your system

First, clone this repo

```bash
git clone https://github.com/unkn0w/proxer
```

Then edit file named "config" and put there list of your domains and destinations
```
my.domain1.com=http://192.168.1.123:3000
my.domain2.com=http://192.168.1.222:8080
my.otherdomain.org=http://somedomain.com
```

Then build your docker image

```bash
docker build -t proxer .
```

Then just run it

```bash
docker run -d -p 80:80 proxer
```

## Known Bugs and Issues

Proxer support HTTP only for now. There is no support for HTTPS :(

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)
