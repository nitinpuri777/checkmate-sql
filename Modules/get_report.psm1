Function Get-Report ([string] $report_filename,
                     [object] $database_config) {
  # Setup server config
  $db_server_name = $database_config.server.name
  if ($database_config.server.include_computer_name) {
    $server_name = $env:computername
    $db_server_name = "$server_name\$db_server_name"
  }

  # Need full path for loading into sqlcmd
  #$script_path = Split-Path -parent $MyInvocation.MyCommand.Definition
  $sql_path = "SQL\$report_filename" #Join-Path $script_path -ChildPath "$report_filename"

  # Execute sql and store results

  #Check if Login is required
  if ($database_config.server.include_login_credentials) {
    $data = sqlcmd `
    -S "$db_server_name" `
    -d $database_config.db_name `
    -U $database_config.username `
    -P $database_config.password `
    -i "$sql_path" `
    -s '|' `
    -I `
    -W `
    | Foreach-Object{ '"' + $_ + '"'} `
    | %{ $_ -replace '\|', '","' }
  }
  else{
  $data = sqlcmd `
    -S "$db_server_name" `
    -d $database_config.db_name `
    -i "$sql_path" `
    -s '|' `
    -I `
    -W `
    | Foreach-Object{ '"' + $_ + '"'} `
    | %{ $_ -replace '\|', '","' }
  }

  # Trip first two rows (unused) and return results
  Return $data[2..($data.count - 3)] -join "`r`n"
}

Export-ModuleMember -Function:Get-Report