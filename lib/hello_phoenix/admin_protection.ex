defmodule HelloPhoenix.Plugs.AdminProtection do

  import Plug.Conn, only: [send_resp:       3,
                           halt:            1,
                          put_status: 2]

  import Phoenix.Controller, only: [render: 3]

  def init(opts) do
  end

  def call(conn, args) do
    check_creds(conn)
  end

  defp check_creds(conn) do
    case HelloPhoenix.Session.admin?(conn) do
      true ->
        conn
      false ->
        conn
        |> put_status(401)
        |> render(HelloPhoenix.ErrorView, "401.html")
    end
  end

end
