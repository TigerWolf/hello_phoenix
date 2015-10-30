defmodule HelloPhoenix.Mailer do
  use Mailgun.Client, domain: Application.get_env(:hello_phoenix, :mailgun_domain),
                      key: Application.get_env(:hello_phoenix, :mailgun_key)

  @from "no-reply@challengecup.club"

  def send_reset_email(email, uuid) do
    send_email to: email,
               from: @from,
               subject: "Password Reset",
               text: "Here is your reset token, go to https://challengecup.club/reset_password and and enter this token to reset your password. Token: " <> uuid
  end

end
