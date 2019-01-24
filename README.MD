# Spring cloud functions

## Local build

```bash
mvnci
```

or

```bash
mvn clean install
```


## Build and deploy


```bash
riff function create reverse --image $DOCKER_ID/reverse \
 -l ./reverse-function \
 --artifact reverse-0.0.1-SNAPSHOT.jar \
 --invoker java --handler=reverse
 
 
riff function create reverse --image $DOCKER_ID/uppercase \
  -l ./uppercase-function \
  --artifact reverse-0.0.1-SNAPSHOT.jar \
  --invoker java --handler=uppercase
```