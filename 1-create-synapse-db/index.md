# Create an Azure Synapse Database 


## Create a Synapse workspace in the Azure portal

1. Open the [Azure portal](https://portal.azure.com), and at the top search for **Synapse**.
1. In the search results, under **Services**, select **Azure Synapse Analytics (workspaces preview)**.
1. Select **Add** to create a workspace.
1. In **Basics**, enter your preferred **Subscription**, **Resource group**, **Region**, and then choose a workspace name. In this tutorial, we'll use **myworkspace**.
1. Navigate to **Select Data Lake Storage Gen 2**. 
1. Under **Account name**, select the account like **[YOUR_PREFIX]datalake.
1. Under **File system name**, select **synapse-data**.
1. Click **Next** button.
1. Under **SQL administrator credentials**, type a Password in both fields.
1. Select **Review + create** > **Create**. Your workspace is ready in a few minutes.

## Open Synapse Studio

After your Azure Synapse workspace is created, you have two ways to open Synapse Studio:

* Open your Synapse workspace in the [Azure portal](https://portal.azure.com). On the top of the **Overview** section, select **Launch Synapse Studio**.
* Go to the `https://web.azuresynapse.net` and sign in to your workspace.

## Create a dedicated SQL pool

1. In Synapse Studio, on the left-side pane, select **Manage** > **SQL pools**.
1. Select **New**
1. For **SQL pool name** select **SQLPOOL1**
1. For **Performance level** choose **DW100C**
1. Select **Review + create** > **Create**. Your dedicated SQL pool will be ready in a few minutes. Your dedicated SQL pool is associated with a dedicated SQL pool database that's also called **SQLPOOL1**.

> ⚠️ A dedicated SQL pool consumes billable resources as long as it's active. You can pause the pool later to reduce costs. Do not forget to delete this resource group at the end of the workshop.

## Create the database schema



## Additional infos

- [📚 Docs - Create a Synapse workspace](https://docs.microsoft.com/en-us/azure/synapse-analytics/get-started-create-workspace)