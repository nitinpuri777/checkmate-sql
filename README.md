# Checkmate SQL Server Integrations
Many on-premise Property Management Systems are backed by a local SQL Database on a server that the property staff has access to.  With appropriate credentials for this database, we can use our Generic PowerShell Script to run SQL Queries, convert the results to CSV, and email them to a Checkmate Integration Email Address (both Classic and Next).


## How to Use
Different businesses wil have different network configurations and credential restrictions.  This script is designed to accomodate everything from querying a remote server with credentials to running a query on a locally installed DB without credentials.  All configuration must be done in the config.json file.


## SQL Scripts
Queries for standard integrations for PMS systems we've encountered are in the SQL folder.

## Sample Config Files
Configuration specifications for certain PMS systems are detailed in these sample config files.
