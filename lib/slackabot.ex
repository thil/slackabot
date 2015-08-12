defmodule Slackabot do
  alias Slackabot.Slack

  def start(_type, _args) do
    Slack.connect
  end
end
