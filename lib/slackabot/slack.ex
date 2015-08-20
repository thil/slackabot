defmodule Slackabot.Slack do
  use GenServer

  alias Slackabot.Sockets.Web
  alias Slackabot.MessageHandler
  alias Slackabot.Client

  def connect do
    GenServer.start_link(__MODULE__, Client.connect_url, name: __MODULE__)
  end

  def init(slack_url) do
    Web.start_link(slack_url, __MODULE__)
  end

  def handle(message = %{type: "message"}) do
    MessageHandler.act(message)
  end

  def handle(m), do: IO.inspect m

  def msg(channel, text) do
    {ms, s, _} = :os.timestamp
    message = %{type: "message", id: (ms * 1_000_000 + s), channel: channel, text: text}

    GenServer.cast __MODULE__, {:msg, message}
  end

  def handle_cast({:msg, message}, socket) do
    Web.msg(socket, message)
    {:noreply, socket}
  end
end
