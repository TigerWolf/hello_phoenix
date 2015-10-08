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
      title: log.amount,
      inserted_at: log.inserted_at,
      activity_id: log.activity_id
    }
  end

end
