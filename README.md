# Ingest & Analyze IoT Data with Azure Synapse Workshop

## Abstract

Most of the IoT value come from analyzing it's data. However, ingesting analyzing high volume of data ca be a complex task. During this workshop, you'll learn how to use Azure Synapse Analytics - a limitless analytics service - to process and make available IoT Data to developers and data analysts.

Duration: 45 minutes

## Prerequisites

- A Microsoft Azure Account
- A basic knowledge of SQL Language

## Content

|  | Step | Objective | 
|--|--|--|
| 00 | [Setup your environment](0-setup-environment/index.md) | Easily setup your Azure subscription for Azure Synapse and simulating IoT devices. |
| 01| [Create an Azure Synapse Database](1-create-synapse-db/index.md) | Create a Synapse Account, and a database schema | 
| 02 | [Ingest IoT Data into Azure Synapse](2-ingest-iot-data/index.md) | Use Stream Analytics to store IoT Data into an Azure Synapse Table
| 03 | [Analyse data using SQL](3-analyze-data/index.md) | Use Synapse Notebooks to explore your data
| 04 | [Analyse raw data stored in flat files using SQL](4-analyze-raw-data/index.md) | Use Synapse to read files from Blob Storage and query them.
    
### Additional content

- Import data from flat files ad-hoc (COPY statement)
- Analyse data from Power BI