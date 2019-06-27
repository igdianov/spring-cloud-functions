#!/usr/bin/env bash

PROJECT_ID=${GKE_PORJECT_ID};

# creating k8s cluster on GKE
gcloud container clusters create istio-demo --project=${PROJECT_ID} \
    --machine-type=n1-standard-2 \
    --num-nodes=2 \
    --zone europe-west1-b \
    --no-enable-legacy-authorization;

# add permissions to the GKE user
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin \
  --user="$(gcloud config get-value core/account)";

export ISTIO_HOME="$(dirname ${ISTIO_PATH})";
kubectl apply -f ${ISTIO_HOME}/install/kubernetes/istio-demo.yaml;

gcloud config set core/project PROJECT_ID

gcloud services enable \
     cloudapis.googleapis.com \
     container.googleapis.com \
     containerregistry.googleapis.com

kubectl apply --selector knative.dev/crd-install=true \
   --filename https://github.com/knative/serving/releases/download/v0.7.0/serving.yaml \
   --filename https://github.com/knative/build/releases/download/v0.7.0/build.yaml \
   --filename https://github.com/knative/eventing/releases/download/v0.7.0/release.yaml \
   --filename https://github.com/knative/serving/releases/download/v0.7.0/monitoring.yaml

kubectl apply --filename https://github.com/knative/serving/releases/download/v0.7.0/serving.yaml --selector networking.knative.dev/certificate-provider!=cert-manager \
   --filename https://github.com/knative/build/releases/download/v0.7.0/build.yaml \
   --filename https://github.com/knative/eventing/releases/download/v0.7.0/release.yaml \
   --filename https://github.com/knative/serving/releases/download/v0.7.0/monitoring.yaml
