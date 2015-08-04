defmodule Slackabot.Slack do
  import Slackabot.Settings
  use HTTPotion.Base

  def connect_url do
    get("rtm.start").body["url"]
  end

  def process_url(url) do
    slack_api <> url <> "?token=#{api_token}"
  end

  def process_response_body(body) do
    body 
    |> Poison.decode!
  end

  def msg(channel, post) do
    body = %{
      username: "slackabot",
      channel: channel,
      text: post,
      token: api_token
    } |> Poison.encode!

    post("chat.postMessage", [body: body])

    # url = process_url("chat.postMessage") <> "&channel=#{channel}&text=#{post}"
    # IO.inspect url
    # HTTPotion.post(url)
  end
end
