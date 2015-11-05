defmodule HelloPhoenix.V1.LogView do
  use HelloPhoenix.Web, :view

  def render("index.json", %{logs: logs}) do
    %{data: render_many(logs, HelloPhoenix.V1.LogView, "log.json")}
  end

  def render("show.json", %{log: log}) do
    %{data: render_one(log, HelloPhoenix.V1.LogView, "log.json")}
  end

  def render("log.json", %{log: log}) do
    %{
      id: log.id,
      amount: log.amount,
      inserted_at: log.inserted_at |> Calendar.Strftime.strftime!("%Y-%m-%eT%H:%M:%SZ"),
      activity_id: log.activity_id,
      points: HelloPhoenix.Log.points(log),
      activity_name: log.activity.name
    }
  end

end
