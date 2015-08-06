defmodule Slackabot.WebsocketClient do
  alias Poison, as: JSON

  @doc """
  Starts the WebSocket server for given ws URL. Received Socket.Message's
  are forwarded to the sender pid
  """
  def start_link(sender, url, headers \\ []) do
    :crypto.start
    :ssl.start
    :websocket_client.start_link(String.to_char_list(url), __MODULE__, [sender],
                                 extra_headers: headers)
  end

  def init([sender], _conn_state) do
    {:ok, %{sender: sender, ref: 0}}
  end

  @doc """
  Closes the socket
  """
  def close(socket) do
    send(socket, :close)
  end

  @doc """
  Receives JSON encoded Socket.Message from remote WS endpoint and
  forwards message to client sender process
  """
  def websocket_handle({:text, msg}, _conn_state, state) do
    IO.inspect msg
    post = Poison.decode!(msg)
    if post["type"] == "message" do
      handle_msg(state, post, post["text"])
    end
    {:ok, state}
  end

  def handle_msg(state, post, "boombot" <> msg) do
    send state.sender, post
  end

  def handle_msg(state, post, msg) do
  end

  def websocket_handle({:ping, _}, _conn_state, state) do
    {:ok, state}
  end


  def websocket_info(a, _conn_state, state) do
    IO.inspect a
    {:reply, {:text, a}, state}
  end

  @doc """
  Sends JSON encoded Socket.Message to remote WS endpoint
  """
  def websocket_info({:send, msg}, _conn_state, state) do
    msg = Map.put(msg, :ref, to_string(state.ref + 1))
    {:reply, {:text, json!(msg)}, put_in(state, [:ref], state.ref + 1)}
  end

  def websocket_info(:close, _conn_state, _state) do
    {:close, <<>>, "done"}
  end

  def websocket_terminate(_reason, _conn_state, _state) do
    :ok
  end

  @doc """
  Sends an event to the WebSocket server per the Message protocol
  """
  def send_event(server_pid, msg, channel) do
    {ms, s, _} = :os.timestamp
    timestamp = (ms * 1_000_000 + s)
    body = %{
      id: timestamp,
      type: "message",
      channel: channel,
      text: msg,
    } |> Poison.encode!

    send server_pid, body
  end


  defp json!(map), do: JSON.encode!(map)
end
