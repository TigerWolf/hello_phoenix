defmodule HelloPhoenix.SummaryController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Log

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
