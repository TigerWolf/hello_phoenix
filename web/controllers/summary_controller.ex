defmodule HelloPhoenix.SummaryController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Log
  alias HelloPhoenix.User
  alias HelloPhoenix.Team

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

  def combined(conn, _params) do

    logs = Repo.all(Log)
      |> Repo.preload([:activity, user: :team])
      |> Enum.group_by(&(&1.user.name))

    users = Enum.reduce(logs, %{}, fn(log, user_map) ->
      days = Enum.group_by(elem(log, 1), &(&1.inserted_at |> Calendar.DateTime.shift_zone!("Australia/Adelaide") |> Calendar.Strftime.strftime!("%A, %e %B %Y")))
      events = Enum.reduce(days, %{}, fn(day, event_map) ->
        activity = Enum.group_by(elem(day, 1), &(&1.activity.name))
        sum = Enum.reduce(activity, %{}, fn(activity, y) ->
          log_sum = Enum.reduce(elem(activity,1), 0, &(&1.amount + &2))
          Map.put(y, elem(activity,0), log_sum)
        end)
        Map.put(event_map,elem(day,0),sum)
      end)
      Map.put(user_map,elem(log,0),events)
    end)

    logs2 = Enum.flat_map(users, fn(user) ->
      traverse_user(user)
    end)
    |> CSVLixir.write
    |> Enum.to_list

    conn |> put_resp_content_type("text/csv") |> send_resp(200, logs2)
  end

  def totals(conn, _params) do
    user = Repo.get!(User, 1)
    logs = Repo.all(
      from l in Log,
        where: l.user_id == ^user.id,
        order_by: [desc: l.inserted_at],
        select: l
    ) |> Repo.preload([:activity, :user])
    # count = 0
    # for log  <- logs do
    #   count = count + Log.points(log)
    # end
    count = Enum.reduce(logs, 0, &(Log.points(&1) + &2))
    render(conn, "totals.html", count: count, user: user)
  end

  def teams(conn, _params) do
    teams = Repo.all(Team) |> Repo.preload([users: [ :team, logs: [:activity, :user]]])
    render(conn, "teams.html", teams: teams)
  end

  def traverse_user(user) do
    {username, dates} = user
    date_result = Enum.flat_map(dates, fn(date) ->
      traverse_date(date, username)
    end)
  end

  def traverse_date(date, username) do
    {date_string, activites} = date
    date_result = Enum.map(activites, fn(activity) ->
      traverse_activities(activity, username, date_string)
    end)
  end

  def traverse_activities(activity, username, date_string) do
    {activity_name, amount} = activity
    [username, activity_name, amount, date_string]
  end

  def team_name(nil), do: ""
  def team_name(team), do: team.name


end
