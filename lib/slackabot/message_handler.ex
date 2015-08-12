defmodule Slackabot.MessageHandler do
  @handlers [
    %{start: "aw yiss ", handler: Slackabot.Handlers.AwYiss},
    %{start: "funcage", handler: Slackabot.Handlers.Funcage}
  ]

  Enum.each @handlers, fn(%{start: start, handler: handle}) ->
    def handle(message = %{text: unquote(start) <> text}) do
      Task.start(unquote(handle), :handle, [message, text])
    end
  end

  def handle(message), do: IO.puts "Unknown Command"
end
