defmodule HelloPhoenix.V1.TeamController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Team

  plug PlugBasicAuth, username: "test", password: "user"

  plug :scrub_params, "team" when action in [:create, :update]

  def index(conn, _params) do
    teams = Repo.all(Team)
    render(conn, "index.json", posts: posts)
  end

end
