# tmate-slave docker

## Usage

```
# build
$ docker build . -t tmate-slave


# run
$ sudo docker run --restart=always --privileged --publish 2222:2222 --name tmate-slave tmate-slave -v  -h ${YOUR_HOSTNAME}
```


