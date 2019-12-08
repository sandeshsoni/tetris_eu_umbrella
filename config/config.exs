# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :elixirconf_eu,
  ecto_repos: [ElixirconfEu.Repo]

config :elixirconf_eu_web,
  ecto_repos: [ElixirconfEu.Repo],
  generators: [context_app: :elixirconf_eu]

# Configures the endpoint
config :elixirconf_eu_web, ElixirconfEuWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "t5C6lNBZ+F2hSerCa+LX1pfcyX6ftaPpSx6ITsiFXRiIZ88ZSGV8Re6Rnf0HxRSL",
  render_errors: [view: ElixirconfEuWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirconfEuWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
