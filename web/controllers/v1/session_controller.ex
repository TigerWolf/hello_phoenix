defmodule HelloPhoenix.V1.SessionController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Session

  plug HelloPhoenix.Plugs.Authenticated

  def create(conn, _params) do
    render(conn, "index.json")
  end


end
