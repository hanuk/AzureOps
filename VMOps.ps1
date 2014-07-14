# 
# Copyright (c) Microsoft.  All rights reserved. 
# 
# Licensed under the Apache License, Version 2.0 (the "License"); 
# you may not use this file except in compliance with the License. 
# You may obtain a copy of the License at //   http://www.apache.org/licenses/LICENSE-2.0 
# 
# Unless required by applicable law or agreed to in writing, software 
# distributed under the License is distributed on an "AS IS" BASIS, 
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 

function PrintMessage($msg)
{
    Write-Host $msg
}
function PrintUsage()
{
    PrintMessage "usage: VMOps ""<subscription_name>"" ""<service_name>""  ""start"" [or ""stop""]"
}

function StartCluster($serviceName, $vmNames)
{
    foreach($vmName in $vmNames)
    {
      Start-AzureVM -ServiceName $serviceName -Name $vmname
    } 
}

function StopCluster($serviceName, $vmNames)
{
    foreach($vmName in $vmNames)
    {
      Stop-AzureVM -ServiceName $serviceName -Name $vmname
    } 
}

function GetVMNames($svcName)
{
    $vmXml = (Get-AzureDeployment -ServiceName $svcName).Configuration
    [System.Xml.XmlDocument]$xd = new-object System.Xml.XmlDocument
    $xd.LoadXml($vmXml)

    $vmList = $xd.ChildNodes
    $vmNames = @()
    foreach($vm in $vmList.ChildNodes )
    {
        $vmNames += $vm.name
    }

    return $vmNames
}

if($args.Length -ne 3)
{
   PrintUsage
   exit
}

$subscriptionName = $args[0].Trim() 
$serviceName=$args[1].Trim()
$action = $args[2].Trim().ToLower()

if ($subscriptionName.Length -eq 0 -or $serviceName.Length -eq 0 -or $action.Length -eq 0)
{
  PrintMessage "Some arguments are empty"
  PrintUsage
  exit
}

Select-AzureSubscription -SubscriptionName $subscriptionName -Current

$vmNames = GetVMNames $serviceName 


if ($action  -eq "start")
{
   PrintMessage "starting the cluster"
   StartCluster $serviceName $vmNames
   PrintMessage "starting complete"
}
elseif ($action  -eq "stop")
{
   PrintMessage "stopping the cluster"
   StopCluster $serviceName $vmNames
   PrintMessage "stopping complete"
}
else 
{
  PrintMessage "Invalid action"
  PrintUsage
  exit
}