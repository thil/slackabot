defmodule Slackabot.Sockets.Web do
  def start_link(sender, url, headers \\ []) do
    :crypto.start
    :ssl.start
    :websocket_client.start_link(String.to_char_list(url), __MODULE__, [sender], extra_headers: headers)
  end

  def init([sender], _conn_state) do
    {:ok, %{sender: sender, ref: 0}}
  end

  def websocket_handle({:text, msg}, _conn_state, state) do
    send state.sender, Poison.decode!(msg)
    {:ok, state}
  end

  def websocket_handle({:ping, _}, _conn_state, state) do
    {:ok, state}
  end

  def websocket_info(msg, _conn_state, state) do
    {:reply, {:text, Poison.encode!(msg)}, state}
  end

  def websocket_terminate(_reason, _conn_state, _state) do
    :ok
  end

  def close(socket) do
    send(socket, :close)
  end
end
