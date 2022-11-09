#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

<#
        .SYNOPSIS
            Creates Table Mappings JSON file
        .DESCRIPTION
            Creates Table Mappings JSON file to be used by a DMS Replication Task.
        .PARAMETER TableListFile
            This is the file where the schemas and tables are listed. Structure of the file should be: schema;table. Eg. dbo;Accounts
        .PARAMETER OutputFolder
            Folder where the output file will be created
        .NOTES
            Tags: DMS, Table Mappings
            Author: Marcos Freccia
        .EXAMPLE
            This will read the table_list.txt file that contains schemas and tables and generate a single Table Mappings file on C:\Temp
            $File = "C:\Temp\table_list.txt"
            $OutputFolder = "C:\Temp"
            New-DMSTableMappingsFile -TableListFile $File -OutputFolder $OutputFolder
    #>
[cmdletbinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$TableListFile,
    [Parameter(Mandatory)][string]$OutputFolder
)
begin{
    if (!(Test-Path $OutputFolder)){
        Write-Output "The folder [$OutputFolder] doesn't exist. Creating it!"
        New-Item -ItemType Directory -Path $OutputFolder

    }
    else {
        Write-Output "Folder [$OutputFolder] exists"
    }
    
}
process {      
        try {
            Write-Output "Generating table mappings for [$((Get-ChildItem $TableListFile).Name)]"
            $OutputFileName = -join ($OutputFolder, "\", (Get-ChildItem $TableListFile).BaseName, ".json")
            $TableList = Import-Csv $TableListFile -Delimiter ";" -Header "schema_name", "table_name"
            $JsonBase = @{}
            $list = New-Object System.Collections.ArrayList

            $count = 1
            foreach ($tb in $TableList) {
                Write-Output "Adding [$($tb.schema_name)].[$($tb.table_name)] to the table mapping"   
                $object_locator = @{"schema-name" = "$($tb.schema_name)"; "table-name" = "$($tb.table_name)" }
                $list.Add(@{"rule-type" = "selection"; "rule-action" = "include"; "rule-id" = "$count"; "rule-name" = "$count"; "object-locator" = $object_locator; }) | Out-Null

                $count += 1
            }
            $jsonBase.Add("rules", $list)

            $jsonBase | ConvertTo-Json -Depth 10 | Out-File $OutputFileName -Append
            Write-Output "Generation completed successfully [$((Get-ChildItem $TableListFile).Name)]"
            Write-Output "New file saved at [$OutputFileName]"
        }
        catch {

            Write-Output $_.
    
        }
    }