defmodule HelloPhoenix.SummaryController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Log

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def csv(conn, _params) do
    logs = Repo.all(Log)
      |> Repo.preload([:activity])
      |> Enum.map( fn(x) ->
        [
          x.id,
          x.amount,
          x.activity_id,
          x.activity.name,
          x.user_id,
          x.inserted_at
        ]
      end)
      |> CSVLixir.write
      |> Enum.to_list
      |> List.insert_at(0, ["id,amount,activity_id,activity name,user id,date\r\n"])
    conn |> put_resp_content_type("text/csv") |> send_resp(200, logs)
  end

end
