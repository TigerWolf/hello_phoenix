defmodule HelloPhoenix.V1.SessionView do
  use HelloPhoenix.Web, :view

  def render("index.json", params) do
    %{data: "true"}
  end

end
