-- Create Room Table
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

COPY INTO [dbo].[Room]
FROM 'https://synapseiotworkshopch.blob.core.windows.net/data/data-rooms.csv'
WITH (
    FILE_TYPE = 'CSV',
    --CREDENTIAL=(IDENTITY= 'Shared Access Signature', SECRET='?sv=2019-02-02&yeahthaisar34ls34cr3th0h0h0'),
    FIELDTERMINATOR=','
    --ROWTERMINATOR=';'
);

-- Create Device Table
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

