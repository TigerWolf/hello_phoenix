defmodule HelloPhoenix.Router do
  use HelloPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/activities", ActivityController
  end

  #Other scopes may use custom stacks.
  scope "/api", HelloPhoenix do
    pipe_through :api
    scope "/v1", V1, as: :v1 do
      resources "/posts", PostController
    end
  end
end
