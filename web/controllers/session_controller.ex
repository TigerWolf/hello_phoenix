defmodule HelloPhoenix.SessionController do
  use HelloPhoenix.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case HelloPhoenix.Session.login(session_params, HelloPhoenix.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

  def reset(conn,params) do
    conn
    |> render("reset.html")
  end

  def reset_pass(conn, %{"session" => session_params}) do
    case HelloPhoenix.Session.reset_password(session_params["recovery_hash"], session_params["password"], session_params["password_confirm"]) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Password updated!")
        |> render("reset.html")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> render("reset.html")
    end
  end

  def request_reset(conn, params) do
    conn
    |> render("request_reset.html")
  end

  def request_reset_send(conn, %{"session" => session_params}) do
    uuid = UUID.uuid4()
    HelloPhoenix.Mailer.send_reset_email(session_params["email"], uuid)
    user = HelloPhoenix.User.find_by_email(session_params["email"])
    user = %{ user | recovery_hash: uuid}
    HelloPhoenix.Repo.update(user)
    conn
    |> put_flash(:info, "Email sent, follow the instructions.")
    |> render("request_reset.html")
  end
end
