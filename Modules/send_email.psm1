Function Send-Email ([string] $report_data,
                     [object] $report_config,
                     [object] $email_config) {
  # Build Attachment
  $attachment_name = $report_config.name.ToLower().Replace(' ', '_') + '.csv'
  $content_type = New-Object Net.Mime.ContentType('text/csv; charset="us-ascii"')
  $content_type.Name = $attachment_name
  $attachment = [System.Net.Mail.Attachment]::CreateAttachmentFromString(
    "$report_data", $content_type)
  $attachment.ContentDisposition.DispositionType = "attachment"

  # Create message and add attachment
  $today = Get-Date -Format d
  $message = New-Object Net.Mail.MailMessage
  $message.From = $email_config.account.address
  $message.To.Add($report_config.destination)
  $message.Subject =
      "[$($email_config.property)] $($report_config.name) Report - $today"
  $message.Attachments.Add($attachment)

  # Send message
  $smtp_client = New-Object `
      Net.Mail.SmtpClient($email_config.server.address,
                           $email_config.server.port)
  $smtp_client.EnableSsl = $true
  $smtp_client.Credentials = New-Object `
      System.Net.NetworkCredential($email_config.account.address,
                                   $email_config.account.password)
  $smtp_client.Send($message)
}

Export-ModuleMember -Function:Send-Email