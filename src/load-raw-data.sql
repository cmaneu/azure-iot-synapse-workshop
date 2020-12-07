

    SELECT TOP 100
        JSON_VALUE (jsonContent, '$.Body.ts') AS DateTime
        ,JSON_VALUE (jsonContent, '$.Body.dev') AS DeviceId
        ,JSON_VALUE (jsonContent, '$.Body.temp') AS Temperature
        --COUNT(jsonContent)
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

-- How many devices I have

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

-- Number Of Devices
    SELECT 
       COUNT(DISTINCT JSON_VALUE (jsonContent, '$.Body.dev')) as NumberOfDevice
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





SELECT
    COUNT(jsonContent)
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












-------------------------
SELECT TOP 100
    jsonContent
FROM
    OPENROWSET(
        BULK 'https://chma1rawstor.dfs.core.windows.net/raw-data-json/chma1iothub/00/2020/12/02/10/02.json',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b',
        ROWTERMINATOR = '0x0b'
    )
    WITH (
        jsonContent varchar(MAX)
    ) AS [result]



SELECT TOP 1000
    JSON_VALUE (jsonContent, '$.Body.ts') AS DateTime
    ,JSON_VALUE (jsonContent, '$.Body.dev') AS DeviceId
    ,JSON_VALUE (jsonContent, '$.Body.temp') AS Temperature
    ,jsonContent
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