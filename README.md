VMOps 
A set of simple PowerShell scripts to help automate various Windows Azure operations.

VMOps.ps1
This script helps to stop or start all the VMs inside a single cloud service.
The script takes the following arguments all of which are mandatory:
* subscription_name: this is the name of the Azure subscription imported into the current PowerShell session
* service_name: name of the cloud service that contains the Virtual Machines
* action: the only allowed values are "start" and "stop" which are self explanatory
* 
EXAMPLE:
Start all the VMs: VMOps "hk-t-svc-west-us" "MSDN Ultimate" "start"
Stop all the VMs: VMOps "hk-t-svc-west-us" "MSDN Ultimate" "stop"

=======================
