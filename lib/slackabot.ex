defmodule Slackabot do
  alias Slackabot.Slack

  def start(_type, _args) do
    Slackabot.Repo.start_link
    Slack.connect
  end
end
