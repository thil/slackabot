defmodule Slackabot do
  def test do
    Socket.Web.connect! "echo.websocket.org"
    |> Socket.Web.recv!
  end
end
