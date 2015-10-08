defmodule HelloPhoenix.V1.ActivityController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Activity

  plug HelloPhoenix.Plugs.Authenticated

  plug :scrub_params, "activities" when action in [:create, :update]

  def index(conn, _params) do
    activities = Repo.all(Activity)
    render(conn, "index.json", activities: activities)
  end

  def show(conn, %{"id" => id}) do
    activity = Repo.get!(Activity, id)
    render conn, "show.json", activity: activity
  end

end
