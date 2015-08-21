defmodule Slackabot.MessageHandler do
  @actions [
    %{start: "aw yiss ",             action: Slackabot.Actions.AwYiss},
    %{start: "funcage",              action: Slackabot.Actions.Funcage},
    %{start: "wtffact",              action: Slackabot.Actions.WtfFact},
    %{start: "boombot image me ",    action: Slackabot.Actions.ImageSearch},
    %{start: "boombot animate me ",  action: Slackabot.Actions.ImageSearch},
    %{start: "@",                    action: Slackabot.Actions.Score},
    %{start: "<@",                   action: Slackabot.Actions.UserScore}
  ]

  Enum.each @actions, fn(%{start: start, action: action}) ->
    def act(message = %{channel: channel, text: unquote(start) <> text}, slack) do
      send slack, %{text: unquote(action).act(text, message), channel: channel}
    end
  end
end
