defmodule Slackabot.Test do
  def test do
    url = Slackabot.Slack.connect_url
    IO.inspect url
    :crypto.start
    :ssl.start
    {:ok, sock} = Slackabot.WebsocketClient.start_link(self, url)
    # IO.inspect url
    # socket =  Socket.Web.connect! url
    # socket |> Socket.Web.recv!
  end


  def connect("wss://" <> url) do
    IO.inspect url
    socket =  Socket.Web.connect! url, 443
    socket |> Socket.Web.recv!
  end
end
