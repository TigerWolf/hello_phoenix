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

  def admin(conn, _params) do
    if admin?(conn) do
      render conn, "admin.html"
    else
      conn
      |> put_status(:not_found)
      |> render(HelloPhoenix.ErrorView, "404.html")
    end
  end
end
