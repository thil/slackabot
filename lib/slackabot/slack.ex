defmodule Slackabot.Slack do
  alias Slackabot.Sockets.Web
  alias Slackabot.MessageHandler
  alias Slackabot.Client

  def connect do
    Web.start_link(Client.connect_url, __MODULE__)
  end

  def handle(message = %{type: "message"}) do
    Task.start MessageHandler, :act, [message, self]
  end

  def handle(m), do: IO.inspect m
end
