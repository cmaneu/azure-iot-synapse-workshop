# Setup your environment

> **Objective**: Setup the IoT services & device simulator in your subscription, so you can focus on Synapse in the next steps.

We've prepared a script so all the base resources are created for you. You just need to execute this script inside a bash shell with [Azure CLI installed](https://docs.microsoft.com/cli/azure/install-azure-cli?wt.mc_id=startup-11038-chmaneu).

**If you don't have installed Azure CLI** we got you covered: you can use this script from [Azure Cloud Shell](https://shell.azure.com), an hosted shell, already loaded with all the tools you need :).

```bash
wget -q -O deploy.sh https://synapseiotworkshopch.blob.core.windows.net/data/deploy.sh && bash deploy.sh
```

This script will ask you some parameters: 
- **Resource group name**: It's the name of the resource group -a sort of folder to host your resources. Choose what you want, but we recommend something like `rg-synapse-workshop`
- **Resource prefix**: It's a short (3 to 5 characters) string that will be prepended on all resources created by the script. This is needed because some service names should be unique across ALL Azure.

When these two parameters are set, the script will create all the resources for you. Creating all these resources take a bit of time: between 15 and 20 minutes on most deployments.

> **Warning**: Azure Cloud Shell timeouts after 20 minutes of inactivity. Be sure to check the window from time to time :smiley:

When the script is done, It'll indicate some basic parameters you should know. And you'll be ready for the next step!

> :moneybag: **Remember**: Creating these resources comes with a cost. To avoid charges, delete the resource group when you've completed this workshop.

<details>
<summary>
What's done inside this script?
</summary>
This script will create and configure a few resources to help you get up and running: 
- An IoT Hub
- 10 IoT Devices
- A Data Lake
- A Synapse workspace
- A Synapse Dedicated SQL pool
</details>

## Want to learn more?

- [⌨️ Learn - Control Azure Services with the CLI](https://docs.microsoft.com/learn/modules/control-azure-services-with-cli/?wt.mc_id=startup-11038-chmaneu)

<hr />

## *[Next: Analyze Row Data](../1-analyze-raw-data/index.md)*