defmodule HelloPhoenix.LayoutView do
  use HelloPhoenix.Web, :view

  def admin?(conn) do
    HelloPhoenix.Session.current_user(conn).admin == true
  end
end
