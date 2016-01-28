defmodule HelloPhoenix.V1.SummaryView do
  use HelloPhoenix.Web, :view

  def render("index.json", %{summary: summary}) do
    %{data:
      true
    }
  end

  def team_name(nil), do: ""
  def team_name(team), do: team.name

end
