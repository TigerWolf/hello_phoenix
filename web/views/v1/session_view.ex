defmodule HelloPhoenix.V1.SessionView do
  use HelloPhoenix.Web, :view

  def render("index.json", %{user: user}) do
    %{data:
      %{
        id: user.id,
        name: user.name,
        email: user.email,
        team: team_name(user.team)
      }
    }
  end

  def team_name(nil), do: ""
  def team_name(team), do: team.name

end
