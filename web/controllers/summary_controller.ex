defmodule HelloPhoenix.SummaryController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Log
  plug HelloPhoenix.Plugs.AdminProtection

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def csv(conn, _params) do
    logs = Repo.all(Log)
      |> Repo.preload([:activity, :user])
      |> Enum.map( fn(x) ->
        [
          x.id,
          x.amount,
          x.activity_id,
          x.activity.name,
          x.activity.points,
          x.user_id,
          x.user.name,
          x.user.email,
          x.inserted_at,
          x.amount * x.activity.points
        ]
      end)
      |> CSVLixir.write
      |> Enum.to_list
      |> List.insert_at(0, ["id,amount,activity_id,activity name,activity points,user id, name, email, date, points sub total\r\n"])
    conn |> put_resp_content_type("text/csv") |> send_resp(200, logs)
  end

end
