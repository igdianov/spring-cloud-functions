#!/usr/bin/env bash

riff function create reverse --image $DOCKER_ID/reverse \
 -l ./reverse-function \
 --artifact reverse-0.0.1-SNAPSHOT.jar \
 --invoker java --handler=reverse


riff function create uppercase --image $DOCKER_ID/uppercase \
  -l ./uppercase-function \
  --artifact uppercase-0.0.1-SNAPSHOT.jar \
  --invoker java --handler=uppercase


riff service create correlator --image projectriff/correlator:s1p2018

riff channel create reverse --cluster-bus stub
riff channel create uppercase --cluster-bus stub
riff channel create replies --cluster-bus stub

riff subscription create reverse-subscription --channel reverse --subscriber reverse --reply-to uppercase
riff subscription create uppercase-subscription --channel uppercase --subscriber uppercase --reply-to replies
riff subscription create correlator-subscription --channel replies --subscriber correlator