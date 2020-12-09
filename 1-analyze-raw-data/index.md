# Analyse raw data stored in flat files using SQL

> **Objective** Query raw iot devices data stored in Data Lake with Synapse Serverless SQL pool.

## Create a Serverless Database and link storage

TODO

## Explore linked data

## Query data

```sql

-- 1. Simply read the JSON
SELECT TOP 100
    JSON_VALUE (jsonContent, '$.Body.ts') AS DateTime
    ,JSON_VALUE (jsonContent, '$.Body.dev') AS DeviceId
    ,JSON_VALUE (jsonContent, '$.Body.temp') AS Temperature
FROM
    OPENROWSET(
        BULK 'https://chma1rawstor.dfs.core.windows.net/raw-data-json/chma1iothub/00/2020/12/*/*/*',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]

--- 2. Average temperature per device, top 1
SELECT
    JSON_VALUE (jsonContent, '$.Body.dev') AS DeviceId
    ,AVG(CAST(JSON_VALUE (jsonContent, '$.Body.temp') AS FLOAT)) AS Temperature
FROM
    OPENROWSET(
        BULK 'https://chma1rawstor.dfs.core.windows.net/raw-data-json/chma1iothub/00/2020/12/*/*/*',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]
GROUP BY JSON_VALUE (jsonContent, '$.Body.dev')

-- Number of messages per device
    SELECT 

        JSON_VALUE (jsonContent, '$.Body.dev') as DeviceId,
       COUNT(jsonContent) as NumberOfMessages
    FROM
        OPENROWSET(
            BULK 'https://chma1rawstor.dfs.core.windows.net/raw-data-json/chma1iothub/00/2020/12/*/*/*',
            FORMAT = 'CSV',
            FIELDQUOTE = '0x0b',
            FIELDTERMINATOR ='0x0b'
            --ROWTERMINATOR = '0x0b'
        )
        WITH (
            jsonContent varchar(MAX)
        ) AS [result]
GROUP BY JSON_VALUE (jsonContent, '$.Body.dev')
ORDER BY NumberOfMessages ASC

```

```sql
SELECT 
    COUNT(JSON_VALUE (jsonContent, '$.Body.ts'))
FROM
    OPENROWSET(
        BULK 'https://chma1rawstor.dfs.core.windows.net/raw-data-json/chma1iothub/00/2020/12/*/*/*.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b'
        --ROWTERMINATOR = '0x0b'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]

```


## Additional infos


- [⌨️ Learn - Import data into Azure Synapse](https://docs.microsoft.com/en-us/learn/modules/import-data-into-asdw-with-polybase/)
- [📚 Docs - External tables](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-external-tables?tabs=sql-pool)
- [📚 Docs - OPENROWSET](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-openrowset)
- [Docs - Query Specific files](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/query-specific-files)