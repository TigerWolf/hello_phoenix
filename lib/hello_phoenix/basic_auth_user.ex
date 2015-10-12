defmodule HelloPhoenix.Plugs.Authenticated do
  @moduledoc """
  A plug for protecting routers with HTTP Basic Auth.

  It expects a `:username` and `:password` to be passed as
  binaries at initialization.

  The user will be prompted for a username and password upon
  accessing any of the routes using this plug.

  If the username and password are correct, the user will be
  able to access the page.

  If the username and password are incorrect, the user will be
  prompted to enter them again.

  ## Example

      defmodule TopSecret do
        import Plug.Conn
        use Plug.Router

        plug PlugBasicAuth, username: "Snorky", password: "Capone"
        plug :match
        plug :dispatch

        get '/speakeasy' do
          conn
          |> put_resp_content_type("text/plain")
          |> send_resp(200, "Welcome to the party.")
        end
      end
  """



  import Logger

  import Plug.Conn, only: [get_req_header:  2,
                           put_resp_header: 3,
                           send_resp:       3,
                           halt:            1,
                           assign:          3
                          ]

  def init(opts) do
  end

  def call(conn, server_creds) do
    # Logger.info server_creds
    conn
    |> get_auth_header
    |> parse_auth
    |> check_creds(server_creds)
  end

  defp get_auth_header(conn) do
    auth = get_req_header(conn, "authorization")
    {conn, auth}
  end

  defp parse_auth({conn, ["Basic " <> encoded_creds | _]}) do
    {:ok, decoded_creds} = Base.decode64(encoded_creds)
    {conn, decoded_creds}
  end
  defp parse_auth({conn, _}), do: {conn, nil}

  defp check_creds({conn, nil}, _) do
    respond_with_login(conn)
  end

  defp check_creds({conn, decoded_creds}, _) do
    credentials = String.split(decoded_creds, ":")

    params = %{"email" => List.first(credentials), "password" => List.last(credentials)}

    case HelloPhoenix.Session.login(params, HelloPhoenix.Repo) do
      {:ok, user} ->
        conn
        |> assign(:user_id, user.id)
      :error ->
        respond_with_login(conn)
    end
  end

  defp respond_with_login(conn) do
    conn
    |> put_resp_header("www-authenticate", "Basic realm=\"Private Area\"")
    |> send_resp(401, "")
    |> halt
  end
end
