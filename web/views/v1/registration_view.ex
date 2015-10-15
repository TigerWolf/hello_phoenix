defmodule HelloPhoenix.V1.RegistrationView do
  use HelloPhoenix.Web, :view

  def render("index.json", params) do
    %{data: "true"}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, HelloPhoenix.V1.RegistrationView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
    }
  end

end
