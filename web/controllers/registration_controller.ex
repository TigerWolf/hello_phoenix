defmodule HelloPhoenix.RegistrationController do
  use HelloPhoenix.Web, :controller
  alias HelloPhoenix.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    conn
    |> put_flash(:error, "Signup closed")
    |> render("new.html", changeset: changeset)
  end

  def create_old(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "admin", "false")
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      case HelloPhoenix.Registration.create(changeset, HelloPhoenix.Repo) do
        {:ok, changeset} ->
          conn
          |> put_flash(:info, "Your account was created")
          |> redirect(to: "/")
        {:error, changeset} ->
          conn
          |> put_flash(:info, "Unable to create account")
          |> render("new.html", changeset: changeset)
      end
    else
      conn
      |> put_flash(:info, "Unable to create account")
      |> render("new.html", changeset: changeset)
    end
  end
end
