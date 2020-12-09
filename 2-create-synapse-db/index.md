# Create an Azure Synapse Database 

> **Objective**: Setup a Synapse workspace, create a database, and create tables within this database to store IoT Data.

## Create a Synapse workspace in the Azure portal

1. Open the [Azure portal](https://portal.azure.com), and at the top search for **Synapse**.
1. In the search results, under **Services**, select **Azure Synapse Analytics**.
1. Select **Add** to create a workspace.
1. In **Basics**, enter your preferred **Subscription**, **Resource group**, **Region**, and then choose a workspace name. In this tutorial, we'll use **myworkspace**.
1. Navigate to **Select Data Lake Storage Gen 2**. 
1. Under **Account name**, select the account like **[YOUR_PREFIX]datalake.
1. Under **File system name**, select **synapse-data**.
1. Click **Next** button.
1. Under **SQL administrator credentials**, type a Password in both fields.
1. Select **Review + create** > **Create**. Your workspace is ready in a few minutes.

> **Warning**: Note down (or remember :) ) your Synapse username and password. We will need it in few steps.

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

Azure Synapse SQL Pools enables you to create tables like in any classic Datawarehouse, except you can now scale to an entire new level.

For this workshop, we'll create 3 tables: 

- A `Room` Table, containing a list of rooms and their associated building,
- A `Device` Table, containing metadata about the IoT devices, including the room they're in,
- A `Measurement` Table, containing all the measurements from these IoT devices.


> **TODO**: Tell that you need to set to SQLPOOL. 

### Room Table

Creating a Table is as easy as creating one in a traditional SQL table. 
To execute this query: 
1. In the Synapse Web UI, go to the **Develop** Tab on the left,
1. Click the Plus (+) sign, and select *SQL Script*
1. On the **Connect to**, ensure to select the SQL Pool you've just created (SQLPOOL1)
1. Paste the following content into the editor
1. Click on **Run** in the top toolbar.

```sql
CREATE TABLE [dbo].[Room]
(
    RoomId int NOT NULL,
    RoomName nvarchar(255) NOT NULL,
    BuildingName nvarchar(255) NOT NULL
)
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
GO
```

> Did you notice `DISTRIBUTION = REPLICATE' at the end of the query?

Now, we'll import data into that table. We could issue a `INSERT` query, but we'll take another approach. We already have all our rooms listed in a CSV File. Thanks to the [`COPY INTO` )(https://docs.microsoft.com/en-us/sql/t-sql/statements/copy-into-transact-sql?view=azure-sqldw-latest) statement, we can load the content of a CSV file (or a JSON, Parquet and ORC) directly into a Synapse Table.

```sql
COPY INTO [dbo].[Room]
FROM 'https://synapseiotworkshopch.blob.core.windows.net/data/data-rooms.csv'
WITH (
    FILE_TYPE = 'CSV',
    --CREDENTIAL=(IDENTITY= 'Shared Access Signature', SECRET='?sv=2019-02-02&yeahthaisar34ls34cr3th0h0h0'),
    FIELDTERMINATOR=','
    --ROWTERMINATOR=';'
);
```

> In this example, note that two parameters are commented: Credential and RowTerminator. You can then load data from a trusted source like a private blob stored into your container.

### Device Table

```sql
CREATE TABLE [dbo].[Device]
(
    DeviceId nvarchar(20) NOT NULL,
    RoomId int NOT NULL
)
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
GO

COPY INTO [dbo].[Device] (RoomId, DeviceId)
FROM 'https://synapseiotworkshopch.blob.core.windows.net/data/data-devices.csv'
WITH (
    FILE_TYPE = 'CSV',
    FIELDTERMINATOR=','
);
```

> Note as we've added some parameter in this "copy into" instruction. As our CSV file is not following the same Column ordering, you can instruct Synapse to load data in a specific order.


### Measurement Table

```sql
-- Create Measurement Table
CREATE TABLE [dbo].[Measurement]
(
    DeviceId nvarchar(20) NOT NULL,
    TimeStamp datetime NOT NULL,
    Temperature float NOT NULL
)
WITH
(
    DISTRIBUTION = HASH(DeviceId),
    CLUSTERED COLUMNSTORE INDEX
)
GO
```

## Additional infos

- [⌨️ Learn - Design a data warehouse with Synapse](https://docs.microsoft.com/en-us/learn/modules/design-azure-sql-data-warehouse/)
- [📚 Docs - Create a Synapse workspace](https://docs.microsoft.com/en-us/azure/synapse-analytics/get-started-create-workspace)