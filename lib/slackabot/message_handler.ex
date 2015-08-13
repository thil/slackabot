defmodule Slackabot.MessageHandler do
  @actions [
    %{start: "aw yiss ", action: Slackabot.Actions.AwYiss},
    %{start: "funcage",  action: Slackabot.Actions.Funcage},
    %{start: "wtffact",  action: Slackabot.Actions.WtfFact}
  ]

  Enum.each @actions, fn(%{start: start, action: action}) ->
    def act(message = %{text: unquote(start) <> text}) do
      Task.start(unquote(action), :act, [message, text])
    end
  end

  def act(_), do: IO.puts "Unknown Command"
end
