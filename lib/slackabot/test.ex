defmodule Slackabot.Test do
  def test do
    url = Slackabot.Slack.connect_url
    IO.inspect url
    :crypto.start
    :ssl.start
    {:ok, sock} = Slackabot.WebsocketClient.start_link(self, url)

    listen(sock)
  end

  def listen(sock) do
    receive do
      %{"channel" => channel, "text" => text} -> Slackabot.WebsocketClient.send_event(sock, "http://thecatapi.com/api/images/get?format=src&type=gif", channel)
    end
    listen(sock)
  end

  def connect("wss://" <> url) do
    IO.inspect url
    socket =  Socket.Web.connect! url, 443
    socket |> Socket.Web.recv!
  end
end
