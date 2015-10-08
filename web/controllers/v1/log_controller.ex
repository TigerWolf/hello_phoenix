defmodule HelloPhoenix.V1.LogController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Log

  plug HelloPhoenix.Plugs.Authenticated

  plug :scrub_params, "log" when action in [:create, :update]

  def index(conn, _params) do
    logs = Repo.all(Log)
    render(conn, "index.json", logs: logs)
  end

  def show(conn, %{"id" => id}) do
    log = Repo.get!(Log, id)
    render conn, "show.json", log: log
  end

end
