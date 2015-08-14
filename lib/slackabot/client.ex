defmodule Slackabot.Client do
  use HTTPotion.Base

  import Slackabot.Settings

  def connect_url do
    get("rtm.start").body["url"]
  end

  def process_url(url) do
    "#{slack_api}#{url}?token=#{api_token}"
  end

  def process_response_body(body) do
    body |> Poison.decode!
  end
end
