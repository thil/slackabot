defmodule Slackabot.Mixfile do
  use Mix.Project

  def project do
    [app: :slackabot,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [
      applications: [:httpotion, :logger, :postgrex, :ecto],
      mod: {Slackabot, []},
      registered: [Slackabot.Slack]
    ]
  end

  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2"},
      {:httpotion, "~> 2.1.0"},
      {:poison, "~> 1.4.0"},
      {:websocket_client, github: "jeremyong/websocket_client"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 0.14.3"}
    ]
  end
end
