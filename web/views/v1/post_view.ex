defmodule HelloPhoenix.V1.PostView do
  use HelloPhoenix.Web, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, HelloPhoenix.V1.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, HelloPhoenix.V1.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      title: post.title,
      content: post.content}
  end
end
