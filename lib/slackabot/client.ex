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

  def get_user_name(user_id) do
    %{status_code: 200, body: body} = HTTPotion.get("#{process_url("users.info")}&user=#{user_id}")
    process_response_body(body)["user"]["name"]
  end
end
