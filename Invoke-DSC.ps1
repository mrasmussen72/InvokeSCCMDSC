#script to invoke an SCCM client to evaluate a specific baseline

$baselineDisplayName = ""
$computerName = ""

$Baselines = Get-WmiObject -ComputerName $computerName -Namespace root\ccm\dcm -Class SMS_DesiredConfiguration
foreach($baseline in $Baselines)
{
    foreach($property in $baseline.Properties)
    {
        
        if($property.Name.ToLower().Equals("displayname"))
        {
            if($property.Value.ToLower().Equals($baselineDisplayName.ToLower()))
            {
                ([wmiclass]"\\$computerName\root\ccm\dcm:SMS_DesiredConfiguration").TriggerEvaluation($baseline.Name, $baseline.Version)
                
            }
            else 
            {
                continue    
            }
        }
    }
}
