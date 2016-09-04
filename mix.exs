defmodule HelloPhoenix.Mixfile do
  use Mix.Project

  def project do
    [app: :hello_phoenix,
     version: "0.0.4",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {HelloPhoenix, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :rollbax, :logger_file_backend,
                     :comeonin, :csvlixir, :calecto, :uuid, :mailgun
                     ]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 1.1.6"},
      {:phoenix_ecto, "~> 2.0"},
      {:postgrex, ">= 0.11.0"},
      {:phoenix_html, "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.9"},
      {:cowboy, "~> 1.0"},
      {:exrm, "~> 0.19"},
      {:comeonin, "~> 1.0"},
      {:plug_basic_auth, "~> 1.0"},
      {:logger_file_backend, "0.0.4"},
      {:rollbax, "~> 0.5"},
      {:csvlixir, "~> 2.0"},
      {:calecto, "~> 0.4.0"},
      {:mailgun, "~> 0.1.1"},
      {:uuid, "~> 1.1" },
   ]
  end
end
