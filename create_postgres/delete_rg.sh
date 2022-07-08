#!/bin/bash
resourceGroup="RogerPokerRG"

while getopts r: flag
do
    case "${flag}" in
        r) resourceGroup=${OPTARG};;
    esac
done

# Delete resource group
az group delete --name $resourceGroup --force-deletion-types Microsoft.Compute/virtualMachines