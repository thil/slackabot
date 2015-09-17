defmodule Slackabot.Actions.UserScore do
  alias Slackabot.Actions.Score
  alias Slackabot.Client

  def act(text, message) do
    [_, user_id, rest] = Regex.run(~r/(.*)>(.*)/, text)

    if user_id == message[:user] do
      rest = "-- for being a cheater"
    end

    Score.act(get_user_name(user_id) <> rest, message)
  end

  defp get_user_name(user_id) do
    Client.get_user_name(user_id)
  end
end
