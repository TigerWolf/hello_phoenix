defmodule HelloPhoenix.V1.TeamView do
  use HelloPhoenix.Web, :view

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, HelloPhoenix.V1.TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{
      id: team.id,
      title: team.name
    }
  end

end
