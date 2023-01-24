#!/bin/bash
#
# Template: https://docs.microsoft.com/de-de/azure/postgresql/single-server/quickstart-create-server-database-azure-cli
#
source config.sh

while getopts r:l:p: flag
do
    case "${flag}" in
        r) resourceGroup=${OPTARG};;
        l) location=${OPTARG};;
        p) password=${OPTARG};;
    esac
done

az postgres flexible-server db list --resource-group $resourceGroup --server-name $server
echo "Creating Database $dbname"
az postgres db create \
    --name $dbname\
    --server $server \
    --resource-group $resourceGroup

