defmodule HelloPhoenix.V1.TeamController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Team

  plug PlugBasicAuth, username: "test", password: "user"

  plug :scrub_params, "team" when action in [:create, :update]

  def index(conn, _params) do
    teams = Repo.all(Team)
    render(conn, "index.json", teams: teams)
  end

  def show(conn, %{"id" => id}) do
    team = Repo.get!(Team, id)
    render conn, "show.json", team: team
  end

end
