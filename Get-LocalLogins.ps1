$query = @'
<QueryList>
<Query Id='0' Path='Security'>
<Select Path='Security'>
*[System[EventID='4624']
and(
EventData[Data[@Name='VirtualAccount']='%%1843']
and
EventData[Data[@Name='LogonType']='2']
)
]
</Select>
</Query>
</QueryList>
'@
$properties = @(
@{n='User';e={$_.Properties[5].Value}},
@{n='Domain';e={$_.Properties[6].Value}},
@{n='TimeStamp';e={$_.TimeCreated}}
@{n='LogonType';e={$_.Properties[8].Value}}
)
Get-WinEvent -FilterXml $query | Select-Object $properties| out-file c:\logs\logon-audit.log
