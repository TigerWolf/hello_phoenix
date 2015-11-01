defmodule HelloPhoenix.V1.SessionController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.User

  plug HelloPhoenix.Plugs.Authenticated

  def create(conn, _params) do
    user = Repo.get!(User, conn.assigns.user_id) |> Repo.preload([:team])
    render(conn, "index.json", user: user)
  end

end
