defmodule Slackabot.Test do
  alias Slackabot.Slack
  alias Slackabot.WebsocketClient

  def test do
    {:ok, sock} = WebsocketClient.start_link(self, Slack.connect_url)

    listen(sock)
  end

  def listen(sock) do
    receive do
      %{"channel" => channel, "text" => "boombot " <> msg} -> handle(sock, channel, msg)
      _ ->
    end
    listen(sock)
  end

  def handle(sock, channel, text) do
    Task.start Slackabot.AwYiss, :handle, [sock, channel, text]
  end
end
