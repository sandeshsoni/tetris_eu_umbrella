defmodule ElixirconfEu.Repo do
  use Ecto.Repo,
    otp_app: :elixirconf_eu,
    adapter: Ecto.Adapters.Postgres
end
