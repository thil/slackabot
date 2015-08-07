defmodule Slackabot.Slack do
  alias Slackabot.Sockets.Web
  alias Slackabot.MessageHandler
  import Slackabot.Settings
  use HTTPotion.Base

  def connect do
    {:ok, sock} = Web.start_link(self, connect_url)

    listen(sock)
  end

  def msg(message) do
    {ms, s, _} = :os.timestamp
    respond = Enum.into %{message | sock: nil}, %{type: "message", id: (ms * 1_000_000 + s)}

    send message.sock, respond
  end

  def process_url(url) do
    slack_api <> url <> "?token=#{api_token}"
  end

  def process_response_body(body) do
    body |> Poison.decode!
  end

  defp listen(sock) do
    receive do
      %{"channel" => channel, "text" => text} ->
        %{sock: sock, channel: channel, text: text} |> MessageHandler.handle
      _ ->
    end
    listen(sock)
  end

  defp connect_url do
    get("rtm.start").body["url"]
  end
end
