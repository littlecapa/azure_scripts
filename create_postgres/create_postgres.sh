#!/bin/bash
#
# Template: https://docs.microsoft.com/de-de/azure/postgresql/single-server/quickstart-create-server-database-azure-cli
#
resourceGroup="RogerPokerRG"
location="westeurope"
password="fjdhfjdhfjhjTTRT%%%&667676767"

while getopts r:l:p: flag
do
    case "${flag}" in
        r) resourceGroup=${OPTARG};;
        l) location=${OPTARG};;
        p) password=${OPTARG};;
    esac
done

# Create a resource group
echo "Creating $resourceGroup in $location..."
az group create --name $resourceGroup --location "$location" --tags $tag

server="postgresql-server-roger"
sku="GP_Gen5_2"
login="azureuser"
# Specify appropriate IP address values for your environment
# to limit / allow access to the PostgreSQL server
startIp=79.0.0.0
endIp=80.0.0.0
echo "Using resource group $resourceGroup with login: $login, password: $password..."

# Create a PostgreSQL server in the resource group
# Name of a server maps to DNS name and is thus required to be globally unique in Azure.
echo "Creating $server in $location..."
az postgres server create --name $server --resource-group $resourceGroup --location "$location" --admin-user $login --admin-password $password --sku-name $sku

# Configure a firewall rule for the server 
echo "Configuring a firewall rule for $server for the IP address range of $startIp to $endIp"
az postgres server firewall-rule create --resource-group $resourceGroup --server $server --name AllowIps --start-ip-address $startIp --end-ip-address $endIp

az postgres server show --resource-group $resourceGroup --name $server

#psql --host=<server_name>.postgres.database.azure.com --port=5432 --username=<admin_user>@<server_name> --dbname=postgres

