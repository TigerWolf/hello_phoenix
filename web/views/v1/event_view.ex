defmodule HelloPhoenix.V1.EventView do
  use HelloPhoenix.Web, :view

  def render("index.json", %{event: event}) do
    %{data: render_one(event, HelloPhoenix.V1.EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      name: event.name,
      announcement: event.announcement
    }
  end


end
