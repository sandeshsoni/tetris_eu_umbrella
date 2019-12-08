use Mix.Config

# Configure your database
config :elixirconf_eu, ElixirconfEu.Repo,
  username: "postgres",
  password: "postgres",
  database: "elixirconf_eu_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixirconf_eu_web, ElixirconfEuWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
