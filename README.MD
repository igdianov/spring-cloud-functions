# Spring cloud functions with knative

## Install knative at docker-for-mac

https://knative.dev/docs/install/knative-with-minikube/

# Spring cloud functions with docker

## Local build

```bash
cd reverse-function
docker build -t uppercase-function .
```

and

```bash
cd reverse-function
docker build -t reverse-function .
```

## Run

```bash
docker run -p8081:8080 uppercase-function:latest 
```

and 

```bash
docker run -p8082:8080 reverse-function:latest 
```

## Invoke the function

```bash
curl http://localhost:8081/uppercase/abcd
```

or

```bash
curl http://localhost:8082/reverse/abcd
```


# Spring cloud functions riff

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
 
 
riff function create uppercase --image $DOCKER_ID/uppercase \
  -l ./uppercase-function \
  --artifact uppercase-0.0.1-SNAPSHOT.jar \
  --invoker java --handler=uppercase
```

## Invoke the function

```bash
riff service invoke reverse  --text -- -w '\n' -d "text"

riff service invoke uppercase  --text -- -w '\n' -d "text"

```

## Invoke the function through channel

### Start monitoring

```bash
watch -n 1 kubectl get pods,ksvc,channel,subscription,deploy
```

### Install correlator

```bash
riff service create correlator --image projectriff/correlator:s1p2018
```

### Create channel

```bash
riff channel create reverse --cluster-bus stub
riff channel create uppercase --cluster-bus stub
riff channel create replies --cluster-bus stub
```

### Create subscriptions

```bash
riff subscription create reverse-subscription --channel reverse --subscriber reverse --reply-to uppercase
riff subscription create uppercase-subscription --channel uppercase --subscriber uppercase --reply-to replies
riff subscription create correlator-subscription --channel replies --subscriber correlator
```

### Invoke the function

```bash
riff service invoke correlator /reverse --text -- -d "Spring cloud functions" -v -H "Knative-Blocking-Request:true"
```

### Cleanup

```bash
riff service delete correlator

riff channel delete reverse
riff channel delete uppercase
riff channel delete replies

riff subscription delete reverse-subscription
riff subscription delete uppercase-subscription
riff subscription delete correlator-subscription
```

## Delete the function

```bash
riff service delete reverse
riff service delete uppercase
```

