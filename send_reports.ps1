$script_path = split-path -parent $MyInvocation.MyCommand.Definition
pushd $script_path

Import-Module .\Modules\get_report.psm1
Import-Module .\Modules\send_email.psm1

function ConvertFrom-Json([object] $item){ 
    add-type -assembly system.web.extensions 
    $ps_js=new-object system.web.script.serialization.javascriptSerializer
    return $ps_js.DeserializeObject($item) 
}

$raw_config = Get-Content -path '.\config.json'
$config = ConvertFrom-Json $raw_config
ForEach ($report_config in $config.reports) {
  $report_data = Get-Report $report_config.filename $config.database
  Send-Email $report_data $report_config $config.email
}
