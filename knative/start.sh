#!/usr/bin/env bash

export PROJECTID=${GKE_PORJECT_ID};

# creating k8s cluster on GKE
gcloud container clusters create istio-demo --project=${PROJECTID} \
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

gcloud config set core/project ${PROJECTID}

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

gcloud iam service-accounts create knative-build --display-name "Knative Build"
gcloud projects add-iam-policy-binding $PROJECTID --member serviceAccount:knative-build@$PROJECTID.iam.gserviceaccount.com --role roles/storage.admin
gcloud iam service-accounts keys create knative-key.json --iam-account knative-build@$PROJECTID.iam.gserviceaccount.com

SERVICE_ACCOUNT_JSON_KEY="$(dirname $0)/knative-key.json";
kubectl create secret generic knative-build-auth --type="kubernetes.io/basic-auth" --from-literal=username="_json_key" --from-file=password=${SERVICE_ACCOUNT_JSON_KEY};
kubectl annotate secret knative-build-auth build.knative.dev/docker-0=https://gcr.io
