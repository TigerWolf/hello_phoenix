defmodule HelloPhoenix.V1.ActivityView do
  use HelloPhoenix.Web, :view

  def render("index.json", %{activities: activities}) do
    %{data: render_many(activities, HelloPhoenix.V1.ActivityView, "activity.json")}
  end

  def render("show.json", %{activity: activity}) do
    %{data: render_one(activity, HelloPhoenix.V1.ActivityView, "activity.json")}
  end

  def render("activity.json", %{activity: activity}) do
    %{
      id: activity.id,
      title: activity.name,
      event_id: activity.event.id
    }
  end

end
