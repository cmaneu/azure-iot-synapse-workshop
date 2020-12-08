printf "\n*** AZURE IOT & SYNAPSE Workshop Creation on Subscription #$SUBSCRIPTION_ID ***\n"
SUBSCRIPTION_ID=`az account show --query id --output tsv`
MAIN_REGION=westeurope

printf "\n*** Working on on Subscription #$SUBSCRIPTION_ID and region $MAIN_REGION***\n"

read -p 'New resource group name: ' RESOURCE_GROUP_NAME
read -p 'Unique prefix (applied to all resources): ' RESOURCE_PREFIX

STORAGE_ACCOUNT_NAME="$RESOURCE_PREFIX"datalake
IOTHUB_NAME="$RESOURCE_PREFIX"iothub

# Create resource group
printf "\n*** Creating resource group $RESOURCE_GROUP_NAME ***\n"
az group create -n $RESOURCE_GROUP_NAME -l $MAIN_REGION

# Create storage account to store IoT Hub messages
printf "\n*** Creating storage account (Data Lake) $STORAGE_ACCOUNT_NAME ***\n"
az storage account create -n $STORAGE_ACCOUNT_NAME -g $RESOURCE_GROUP_NAME -l $MAIN_REGION --sku Standard_LRS --kind StorageV2 --enable-hierarchical-namespace true

az storage fs create -n "raw-data" --account-name $STORAGE_ACCOUNT_NAME
az storage fs create -n "synapse-data" --account-name $STORAGE_ACCOUNT_NAME

STORAGE_ACCOUNT_CONNECTION_STRING=`az storage account show-connection-string -g $RESOURCE_GROUP_NAME -n $STORAGE_ACCOUNT_NAME -o tsv`
printf "\n   Storage Account CS:  $STORAGE_ACCOUNT_CONNECTION_STRING\n"

# Create IoT Hub
printf "\n\n\n"
printf "\n*** Creating IoT Hub ***\n"
az iot hub create -g $RESOURCE_GROUP_NAME -n $IOTHUB_NAME -l $MAIN_REGION

# - Add output to storage account
printf "\n   - Setting up routing \n" 
az iot hub routing-endpoint create --hub-name $IOTHUB_NAME \
--endpoint-name "datalake" \
--endpoint-resource-group $RESOURCE_GROUP_NAME \
--endpoint-subscription-id $SUBSCRIPTION_ID \
--encoding json \
--endpoint-type azurestoragecontainer \
--batch-frequency 60 --chunk-size 10 \
--connection-string $STORAGE_ACCOUNT_CONNECTION_STRING \
--resource-group $RESOURCE_GROUP_NAME \
--container-name "raw-data"

az iot hub route create --hub-name $IOTHUB_NAME \
--route-name "all-to-datalake" \
--source-type DeviceMessages \
--endpoint-name "datalake" \
--resource-group $RESOURCE_GROUP_NAME \

az iot hub route create --hub-name $IOTHUB_NAME \
--route-name "all-to-default" \
--source-type DeviceMessages \
--endpoint-name "events" \
--resource-group $RESOURCE_GROUP_NAME \

# Create Consumer group for ASA
az iot hub consumer-group create --hub-name $IOTHUB_NAME --name StreamAnalytics

# - Create devices
az iot hub device-identity create -n $IOTHUB_NAME -d "simulated-1"
az iot hub device-identity create -n $IOTHUB_NAME -d "simulated-2"
az iot hub device-identity create -n $IOTHUB_NAME -d "simulated-3"
az iot hub device-identity create -n $IOTHUB_NAME -d "simulated-4"
az iot hub device-identity create -n $IOTHUB_NAME -d "simulated-5"
az iot hub device-identity create -n $IOTHUB_NAME -d "simulated-6"
az iot hub device-identity create -n $IOTHUB_NAME -d "simulated-7"
az iot hub device-identity create -n $IOTHUB_NAME -d "simulated-8"
az iot hub device-identity create -n $IOTHUB_NAME -d "simulated-9"
az iot hub device-identity create -n $IOTHUB_NAME -d "simulated-10"

# - Get Connection String
IOTHUB_CS=`az iot hub show-connection-string --name $IOTHUB_NAME --policy-name iothubowner --output tsv`

#  Create an ACI and launch it.
az container create -g $RESOURCE_GROUP_NAME --name "$RESOURCE_PREFIX"simulator --image cmaneu/mqttdevicesim:latest --secure-environment-variables IOTHUB_CS="IOTHUB_CS" IOTHUB_FQDN="IOTHUB_NAME".azuredevices.net  --restart-policy Never

## Create a Synapse Workspace & Pool
SYNAPSE_NAME="$RESOURCE_PREFIX"synapsews
az synapse workspace create --name $SYNAPSE_NAME -g $RESOURCE_GROUP_NAME \
--sql-admin-login-user demo \
--sql-admin-login-password Password123! \
--location $MAIN_REGION \
--storage-account $STORAGE_ACCOUNT_NAME --file-system "synapse-data"

az synapse sql pool create --name sqlpool --performance-level "DW100c" \
--workspace-name $SYNAPSE_NAME --resource-group $RESOURCE_GROUP_NAME


printf "------------------------------"
printf "Hooray! Your workshop environment is now ready."
