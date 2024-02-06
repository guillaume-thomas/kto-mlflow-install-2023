#!/bin/bash

cd k8s
echo Uninstall kto-mlflow
oc delete -f minio.yml
oc delete -f mysql.yml
oc delete -f mlflow.yml
oc delete -f dailyclean.yml
cd ..