defmodule HelloPhoenix.V1.LogController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Log

  plug HelloPhoenix.Plugs.Authenticated

  plug :scrub_params, "log" when action in [:create, :update]

  def index(conn, _params) do
    user_id = conn.assigns.user_id
    logs = Repo.all(
      from l in Log,
        where: l.user_id == ^user_id,
        select: l
    ) |> Repo.preload([:activity])
    render(conn, "index.json", logs: logs)
  end

  def show(conn, %{"id" => id}) do
    log = Repo.get!(Log, id) |> Repo.preload([:activity])
    render conn, "show.json", log: log
  end

  def create(conn, %{"log" => log_params}) do

    log_params = Map.put(log_params, "user_id", conn.assigns.user_id)
    changeset = Log.changeset((%Log{} |> Repo.preload :activity), log_params)

    case Repo.insert(changeset) do
      {:ok, log} ->
        if log_params["yesterday"] == true do

          {:ok, yesterday_date} = log.inserted_at |> Calendar.DateTime.advance(-86400)
          {:ok, formatted_date} = Calecto.DateTimeUTC.cast(yesterday_date)

          case Repo.update(%{log | :inserted_at => formatted_date}) do
            {:ok, log} ->
              success = true
              # Logger.info "success"
            {:error, changeset} ->
              success = false
              # Logger.info "error"
            end
        end
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
