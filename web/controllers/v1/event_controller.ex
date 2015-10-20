defmodule HelloPhoenix.V1.EventController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Event

  plug HelloPhoenix.Plugs.Authenticated

  plug :scrub_params, "event" when action in [:create, :update]

  def index(conn, _params) do
    event = Repo.get!(Event, 1)
    render(conn, "index.json", event: event)
  end

end
