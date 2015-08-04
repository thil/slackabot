defmodule Slackabot.Settings do
  def slack_api do
    "https://slack.com/api/"
  end

  def api_token do
    System.get_env("SLACK_BOT_TOKEN")
  end
end
