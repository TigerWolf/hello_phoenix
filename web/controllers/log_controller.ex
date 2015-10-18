defmodule HelloPhoenix.LogController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Log
  alias HelloPhoenix.Activity

  plug :scrub_params, "log" when action in [:create, :update]

  def index(conn, _params) do
    logs = Repo.all(Log) |> Repo.preload ([:activity, :user])
    render(conn, "index.html", logs: logs)
  end

  def new(conn, _params) do
    activities = Repo.all(Activity)
      |> Enum.map( fn(activity) ->
      { activity.name, activity.id}
    end)
    changeset = Log.changeset(%Log{} |> Repo.preload ([:activity, :user]))
    render(conn, "new.html", changeset: changeset, activities: activities)
  end

  def create(conn, %{"log" => log_params}) do
    log_params = Map.put(log_params, "user_id", HelloPhoenix.Session.current_user(conn).id)
    changeset = Log.changeset(%Log{}, log_params)

    case Repo.insert(changeset) do
      {:ok, _log} ->
        conn
        |> put_flash(:info, "Log created successfully.")
        |> redirect(to: log_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    log = Repo.get!(Log, id) |> Repo.preload [:activity, :user]
    render(conn, "show.html", log: log)
  end

  def edit(conn, %{"id" => id}) do
    activities = Repo.all(Activity)
      |> Enum.map( fn(activity) ->
      { activity.name, activity.id}
    end)
    log = Repo.get!(Log, id)
    changeset = Log.changeset(log)
    render(conn, "edit.html", log: log, changeset: changeset, activities: activities)
  end

  def update(conn, %{"id" => id, "log" => log_params}) do
    log = Repo.get!(Log, id)
    changeset = Log.changeset(log, log_params)

    case Repo.update(changeset) do
      {:ok, log} ->
        conn
        |> put_flash(:info, "Log updated successfully.")
        |> redirect(to: log_path(conn, :show, log))
      {:error, changeset} ->
        render(conn, "edit.html", log: log, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    log = Repo.get!(Log, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(log)

    conn
    |> put_flash(:info, "Log deleted successfully.")
    |> redirect(to: log_path(conn, :index))
  end
end
