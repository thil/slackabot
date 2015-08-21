defmodule Slackabot.Actions.Score do
  alias Slackabot.Slack
  alias Slackabot.Repo
  alias Slackabot.Queries.Score, as: Query
  alias Slackabot.Models.Score

  def act(message, text) do
    score = process_text(text)
    Slack.msg(message.channel, score_text(score))
  end

  def score_text(score) do
    "#{score.target} #{score.value}"
  end

  defp create_or_update_score(target, "++") do
    create_or_update_score(target, 1)
  end

  defp create_or_update_score(target, "--") do
    create_or_update_score(target, -1)
  end

  defp create_or_update_score(target, value)
  when is_integer(value) do
    case Query.by_target(target) do
      nil ->
        {:ok, score} = create_score(target, value)
        score
      score ->
        {:ok, score} = update_score(score, value)
        score
    end
  end

  defp update_score(score, value) do
    %{score | value: (score.value + value)}
    |> Repo.update
  end

  defp create_score(target, value) do
    Repo.insert(%Score{target: target, value: value})
  end

  defp process_text(text) do
    cond do
      results = Regex.run(~r/(.*)([\+\-][\+\-])\sfor\s(.*)/, text) ->
        [_, target, operator, reason] = results
        create_or_update_score(target, operator)
      results = Regex.run(~r/(.*)([\+\-][\+\-])/, text) ->
        [_, target, operator] = results
        create_or_update_score(target, operator)
    end
  end
end
