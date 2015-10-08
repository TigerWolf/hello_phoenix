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

  def create(conn, %{"log" => log_params}) do
    changeset = Log.changeset(%Log{}, log_params)

    case Repo.insert(changeset) do
      {:ok, log} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_log_path(conn, :show, log))
        |> render("show.json", log: log)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HelloPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

end
