defmodule HelloPhoenix.V1.RegistrationController do
  use HelloPhoenix.Web, :controller
  alias HelloPhoenix.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create_old(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "admin", false)
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("user.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HelloPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def create(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "admin", "false")
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      case HelloPhoenix.Registration.create(changeset, HelloPhoenix.Repo) do
        {:ok, changeset} ->
          conn
          |> put_status(:created)
          |> render("user.json", user: changeset)
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(HelloPhoenix.ChangesetView, "error.json", changeset: changeset)
      end
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(HelloPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
