defmodule HelloPhoenix.LogController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Log
  alias HelloPhoenix.Activity

  plug :scrub_params, "log" when action in [:create, :update]

  def index(conn, _params) do

    if admin?(conn) do
      logs = Repo.all(Log) |> Repo.preload ([:activity, :user])
      render(conn, "index.html", logs: logs, current_user: current_user(conn))
    else
      user = current_user(conn)
      if user do
        logs = Repo.all(
          from l in Log,
            where: l.user_id == ^user.id,
            order_by: [desc: l.inserted_at],
            select: l
        ) |> Repo.preload([:activity, :user])
        render(conn, "index.html", logs: logs, current_user: current_user(conn))
      else
        conn
        |> put_status(401)
        |> render(HelloPhoenix.ErrorView, "401.html")
      end
    end

  end

  def activities do
    Repo.all(Activity)
      |> Enum.map( fn(activity) ->
      { activity.name, activity.id}
    end)
  end

  def new(conn, _params) do
    changeset = Log.changeset(%Log{} |> Repo.preload ([:activity, :user]))
    render(conn, "new.html", changeset: changeset, activities: activities, current_user: current_user(conn))
  end

  def create(conn, %{"log" => log_params}) do
    #TODO: Ensure only users can edit their own logs but admins can edit all
    log_params = Map.put(log_params, "user_id", HelloPhoenix.Session.current_user(conn).id)
    changeset = Log.changeset(%Log{}, log_params)

    case Repo.insert(changeset) do
      {:ok, log} ->
        if (log_params["yesterday"] == true || log_params["yesterday"] == "true") do

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
        |> put_flash(:info, "Log created successfully.")
        |> redirect(to: log_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, activities: activities)
    end
  end

  def show(conn, %{"id" => id}) do
    if !admin?(conn) do
      conn
      |> put_status(:not_found)
      |> render(HelloPhoenix.ErrorView, "404.html")
    else
      log = Repo.get!(Log, id) |> Repo.preload [:activity, :user]
      render(conn, "show.html", log: log)
    end
  end

  #
  def edit(conn, %{"id" => id}) do
    if !admin?(conn) do
      conn
      |> put_status(:not_found)
      |> render(HelloPhoenix.ErrorView, "404.html")
    else
      log = Repo.get!(Log, id)
      changeset = Log.changeset(log)
      render(conn, "edit.html", log: log, changeset: changeset, activities: activities, current_user: current_user(conn))
    end
  end

  def update(conn, %{"id" => id, "log" => log_params}) do
    #TODO: Ensure only users can edit their own logs but admins can edit all
    # log_params = Map.put(log_params, "user_id", HelloPhoenix.Session.current_user(conn).id)

    log = Repo.get!(Log, id)
    changeset = Log.changeset(log, log_params)
    if admin?(conn) do
      case Repo.update(changeset) do
        {:ok, log} ->
          conn
          |> put_flash(:info, "Log updated successfully.")
          |> redirect(to: log_path(conn, :show, log))
        {:error, changeset} ->
          render(conn, "edit.html", log: log, changeset: changeset, activities: activities)
      end
    else
      conn
      |> put_flash(:info, "Log cannot be updated.")
      |> redirect(to: log_path(conn, :show, log))
    end
  end

  def delete(conn, %{"id" => id}) do
    log = Repo.get!(Log, id)
    if log.user_id == HelloPhoenix.Session.current_user(conn).id do

      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(log)
    end

    conn
    |> put_flash(:info, "Log deleted successfully.")
    |> redirect(to: log_path(conn, :index))
  end
end
