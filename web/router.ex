defmodule HelloPhoenix.Router do
  use HelloPhoenix.Web, :router
  use Phoenix.Router

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
    get "/rules", PageController, :rules
    get "/apps", PageController, :apps
    get "/admin", PageController, :admin

    resources "/activities", ActivityController
    resources "/users", UserController
    resources "/events", EventController
    resources "/teams", TeamController
    resources "/logs", LogController
    get       "/summary", SummaryController, :index
    get       "/summary/totals", SummaryController, :totals
    get       "/summary/teams", SummaryController, :teams
    get       "/summary/csv", SummaryController, :csv
    get       "/summary/combined", SummaryController, :combined


    get    "/register", RegistrationController, :new
    post   "/register", RegistrationController, :create

    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create
    delete "/logout", SessionController, :delete
    get    "/reset_password",  SessionController, :reset
    post    "/reset",  SessionController, :reset_pass
    get    "/request_reset",  SessionController, :request_reset
    post    "/request_reset",  SessionController, :request_reset_send

  end

  #Other scopes may use custom stacks.
  scope "/api", HelloPhoenix do
    pipe_through :api
    scope "/v1", V1, as: :v1 do
      resources "/teams", TeamController
      resources "/activities", ActivityController
      resources "/logs", LogController
      get       "/login",  SessionController, :create
      post      "/register", RegistrationController, :create
      get       "/event", EventController, :index
      get       "/summary", SummaryController, :index
    end
  end
end
