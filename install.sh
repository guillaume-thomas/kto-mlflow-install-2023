#!/bin/bash
echo "Please insert your Openshift username:"
read varname
echo We will working with $varname-dev namespace

sed -i 's/{%user%}/'"$varname"'/g' ./k8s/job.yml
sed -i 's/{%user%}/'"$varname"'/g' ./k8s/mlflow.yml

echo "Please insert your Openshift cluster:"
read varcluster
echo Your cluster is $varcluster

sed -i 's/{%cluster%}/'"$varcluster"'/g' ./k8s/job.yml

cd k8s

echo Install kto-mlflow
oc apply -f minio.yml
oc apply -f mysql.yml
oc apply -f mlflow.yml
oc apply -f dailyclean.yml
oc label deployment dailyclean-api axa.com/dailyclean=false
oc label statefulset mysql axa.com/dailyclean=true
echo Waiting to kto-mlflow to start
sleep 40
echo Init dataset
oc apply -f job.yml
cd ..
echo Upload in progress
sleep 60
echo End of installation


