defmodule HelloPhoenix.LogView do
  use HelloPhoenix.Web, :view

  def admin?(conn) do
    logged_in(conn.assigns.current_user) == true
  end

  def logged_in(nil), do: false

  # TODO: doesnt look right for normal users
  def logged_in(current_user), do: current_user.admin

end
