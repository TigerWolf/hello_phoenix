defmodule HelloPhoenix.Session do
  alias HelloPhoenix.User

  def login(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if is_integer(id) do
      if id, do: HelloPhoenix.Repo.get(User, id)
    else
      id
    end
  end

  def logged_in?(conn), do: !!current_user(conn)

  def admin?(conn) do
    case current_user(conn) do
      nil ->
        false
      _ ->
        current_user(conn).admin
      end
  end

  @doc """
    Triggers an error when `password` and `password_confirm` mismatch.
  """
  def reset_password(_, password, password_confirm) when password != password_confirm do
    {:error, "passwords must match"}
  end

  @doc """
    Triggers an error when `recovery_hash` is invalid.
  """
  def reset_password(recovery_hash, _, _)
    when is_nil(recovery_hash)
    or recovery_hash == "" do
    {:error, "invalid recovery hash"}
  end

  @doc """
    Resets the password for the user with the given `recovery_hash`.
  """
  def reset_password(recovery_hash, password, password_confirm, repo \\ HelloPhoenix.User)  when password == password_confirm do
    hash = Comeonin.Bcrypt.hashpwsalt(password)
    repo.find_by_recovery_hash(recovery_hash)
    |> reset_user_password(hash, repo)
  end

  #
  # Private functions
  #
  defp reset_user_password(nil,_,_) do
    {:error, "invalid recovery hash"}
  end

  defp reset_user_password({:error, message},_,_) do
    {:error, message}
  end

  defp reset_user_password(user, hash, repo) do
    repo.change_password(user, hash)
  end

end
