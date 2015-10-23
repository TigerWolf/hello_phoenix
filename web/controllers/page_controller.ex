defmodule HelloPhoenix.PageController do
  use HelloPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def rules(conn, _params) do
    render conn, "rules.html"
  end

  def apps(conn, _params) do
    render conn, "apps.html"
  end
end
