# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :hello_phoenix, HelloPhoenix.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "PkDUJV01KK4mBC1GjbCeBNNCaxevqK6dtB/XYHYiyv2W5m3Bt9XGjbq4ta3XsyMa",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: HelloPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

# This line was automatically added by ansible-elixir-stack setup script
if System.get_env("SERVER") do
  config :phoenix, :serve_endpoints, true
end

config :rollbax,
  access_token: "389ed0b5c7c44b83b1550fcc1ce28f1a",
  environment: "production"
