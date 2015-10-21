defmodule HelloPhoenix.UserView do
  use HelloPhoenix.Web, :view

  def team_name(nil), do: ""
  def team_name(team), do: team.name

end
