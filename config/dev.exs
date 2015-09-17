use Mix.Config
  config :slackabot, Slackabot.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "postgres://postgres@localhost:5432/slackabot_dev",
  size: 20
