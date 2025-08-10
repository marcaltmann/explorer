defmodule ExplorerWeb.UserSessionHTML do
  use ExplorerWeb, :html

  embed_templates "user_session_html/*"

  defp local_mail_adapter? do
    Application.get_env(:explorer, Explorer.Mailer)[:adapter] == Swoosh.Adapters.Local
  end
end
