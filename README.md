# Generate Table Mappings for AWS DMS Replication tasks using PowerShell

This PowerShell script takes a CSV file having names of schemas and tables to be migrated, and generates the required table mappings to be used when creating AWS Database Migration replication tasks. Creation of DMS Replication instances, DMS endpoints and replication tasks are not addressed by this tool.

### Prerequisites

Microsoft PowerShell 3.1 through 5.1, or PowerShell Core 6.0 or later.

## Usage

```
posh-dms-table-mapping-generator.ps1 --TableListFile [PATH_OF_THE_CSV_FILE] --OutputFolder [PATH_WHERE_TO_OUTPUT_JSON_FILE]

```

## Input arguments

| Name | Description | Required|
| :---- |:----------- |:--------|
|TableListFile|Location of the CSV file containing the schema and table names to generate tha table mappings file. The format should be **schema_name;table_name**| True |
|OutputFolder|Location where the table mappings JSON file will be generated and saved. | True |

## Illustration

Run the below mentioned command with the provided sample arguments to generate sample a table mappings JSON file of three tables.

```
.\posh-dms-table-mapping-generator.ps1 --TableListFile table_list.csv --OutputFolder C:\Temp

```

The above sample command generates a single file named table_list.json in the **C:\Temp** folder.

## License

Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: MIT-0

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
