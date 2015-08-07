defmodule Slackabot.MessageHandler do
  @handlers [
    Slackabot.Handlers.AwYiss
  ]

  def handle(message) do
    Enum.each @handlers, fn(handler) -> Task.start(handler, :handle, [message]) end
  end
end
