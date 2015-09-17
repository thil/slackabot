defmodule Slackabot.MessageHandler do
  @actions [
    %{start: "aw yiss ",             action: Slackabot.Actions.AwYiss},
    %{start: "funcage",              action: Slackabot.Actions.Funcage},
    %{start: "wtffact",              action: Slackabot.Actions.WtfFact},
    %{start: "boombot image me ",    action: Slackabot.Actions.ImageSearch},
    %{start: "@",                    action: Slackabot.Actions.Score},
    %{start: "<@",                   action: Slackabot.Actions.UserScore},
    %{start: "boombot bomb ",        action: Slackabot.Actions.Bomb}
  ]

  Enum.each @actions, fn(%{start: start, action: action}) ->
    def act(message = %{channel: channel, text: unquote(start) <> text}, slack) do
      respond(slack, channel, unquote(action).act(text, message))
    end
  end

  defp respond(slack, channel, [msg | tail]) do
    send slack, %{text: msg, channel: channel }
    respond(slack, channel, tail)
  end

  defp respond(slack, channel, msg) do
    send slack, %{text: msg, channel: channel }
  end
end
