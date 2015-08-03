defmodule Slackabot.Slack do
  import Slackabot.Settings
  use HTTPotion.Base

  def connect_url do
    get("api/rtm.start").body["url"]
  end

  def process_url(url) do
    slack_api <> url <> "?token=#{api_token}"
  end

  def process_response_body(body) do
    body |> IO.iodata_to_binary |> :jsx.decode
  end
end
