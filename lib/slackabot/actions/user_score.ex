defmodule Slackabot.Actions.UserScore do
  alias Slackabot.Actions.Score
  alias Slackabot.Client

  def act(message, text) do
    [_, user_id, rest] = Regex.run(~r/(.*)>(.*)/, text)
    Score.act(message, get_user_name(user_id) <> rest)
  end

  defp get_user_name(user_id) do
    Client.get_user_name(user_id)
  end
end
