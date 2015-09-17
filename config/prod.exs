use Mix.Config
  config :slackabot, Slackabot.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  size: 20
