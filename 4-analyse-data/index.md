# Analyse data using SQL

> **Objective** Create a simple SQL Query that analyse data stored into Synapse.

You can now go back to Synapse Web UI to execute your queries over the SQL Dedicated pool.

## Do simple queries with SQL

```sql
SELECT COUNT(*) FROM [dbo].[Measurement]
```

```sql
SELECT TOP 100 * FROM [dbo].[Measurement]
WHERE Temperature > 6
```

### Which building has a temperature over 10 degrees?

```sql
SELECT TOP 100  
    Temperature
    ,Measurement.DeviceId
    ,Device.RoomId
    ,BuildingName
FROM [dbo].[Measurement]
LEFT JOIN Device ON [Measurement].DeviceId = Device.DeviceId
LEFT JOIN Room ON [Device].RoomId = Room.RoomId
WHERE Temperature > 10
```

Now let's see which buildings have a temperature over 10, and the average temperature

```sql
SELECT
    BuildingName
    ,AVG(Temperature) as AverageTemperature
    ,COUNT([Measurement].DeviceId) as NumberOfDevices
FROM [dbo].[Measurement]
LEFT JOIN Device ON [Measurement].DeviceId = Device.DeviceId
LEFT JOIN Room ON [Device].RoomId = Room.RoomId
WHERE Temperature > 10
GROUP BY BuildingName
```

## Additional infos

- [⌨️ Learn - Query data in Azure Synapse](https://docs.microsoft.com/en-us/learn/modules/query-azure-sql-data-warehouse/?wt.mc_id=startup-11038-chmaneu)
- [📚 Docs - Explore SQL Data](https://docs.microsoft.com/en-us/azure/synapse-analytics/get-started-analyze-sql-pool#explore-the-nyc-taxi-data-in-the-dedicated-sql-pool?wt.mc_id=startup-11038-chmaneu)