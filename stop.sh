#!/usr/bin/env bash

riff service delete correlator

riff channel delete reverse
riff channel delete uppercase
riff channel delete replies

riff subscription delete reverse-subscription
riff subscription delete uppercase-subscription
riff subscription delete correlator-subscription

riff service delete reverse
riff service delete uppercase