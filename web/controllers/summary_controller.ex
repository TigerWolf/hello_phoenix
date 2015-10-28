defmodule HelloPhoenix.SummaryController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Log
  plug HelloPhoenix.Plugs.AdminProtection

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def csv(conn, _params) do
    logs = Repo.all(Log)
      |> Repo.preload([:activity, user: :team])
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
          x.inserted_at |> Calendar.DateTime.shift_zone!("Australia/Adelaide") |> Calendar.Strftime.strftime!("%A, %e %B %Y"),
          x.amount * x.activity.points,
          x.user.team_id,
          team_name(x.user.team)
        ]
      end)
      |> CSVLixir.write
      |> Enum.to_list
      |> List.insert_at(0, ["id,amount,activity_id,activity name,activity points,user id, name, email, date, points sub total, team id,\r\n"])
    conn |> put_resp_content_type("text/csv") |> send_resp(200, logs)
  end

  def team_name(nil), do: ""
  def team_name(team), do: team.name


end
