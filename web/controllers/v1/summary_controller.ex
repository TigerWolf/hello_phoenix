defmodule HelloPhoenix.V1.SummaryController do
  use HelloPhoenix.Web, :controller

  plug HelloPhoenix.Plugs.Authenticated

  alias HelloPhoenix.Log

  import Logger

  def index(conn, _params) do
    user_id = conn.assigns.user_id
    logs = Repo.all(
      from l in Log,
        where: l.user_id == ^user_id,
        select: l
    ) |> Repo.preload([:activity])

    # WEEK NUMBER>?
    sorted_logs = Enum.group_by(logs,
     &(&1.inserted_at |> Calendar.DateTime.shift_zone!("Australia/Adelaide") |> Calendar.Strftime.strftime!("%w %m %Y")))


    Logger.info inspect(sorted_logs)

    # get points for each log
    # HelloPhoenix.Log.points()
    summary = sorted_logs

    # Split by week
    render(conn, "index.json", summary: summary)
  end

  def weekly_calculation(weekly_logs) do
    # Enum.map(sorted_logs, )
    Enum.map(weekly_logs, fn(log) ->
      log + log.amount
    end)
  end


end
