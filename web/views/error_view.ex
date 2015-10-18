defmodule HelloPhoenix.ErrorView do
  use HelloPhoenix.Web, :view

  # def render("404.html", _assigns) do
  #   "Page not found"
  # end

  def render("404.html", _assigns) do
    render("not-found.html", _assigns)
  end

  # def render("500.html", _assigns) do
  #   "Server internal error"
  # end

  def render("500.html", _assigns) do
    render("internal-error.html", _assigns)
  end

  def render("401.html", _assigns) do
    render("not-authorised.html", _assigns)
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
