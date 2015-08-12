defmodule Slackabot do
  alias Slackabot.Slack

  def run do
    Slack.connect
  end
end
