defmodule Slackabot.Actions.Score do
  alias Slackabot.Slack
  alias Slackabot.Repo
  alias Slackabot.Queries.Score, as: Query
  alias Slackabot.Models.Score
  alias Slackabot.Models.Reason

  def act(message, text) do
    desc = process_text(text)
    Slack.msg(message.channel, desc)
  end

  defp score_desc({score, reason}) do
    "#{score.target} score: #{score.value}, #{reason.delta} for #{reason.text}"
  end

  defp score_desc(score) do
    "#{score.target} score: #{score.value}"
  end

  defp create_or_update_score(target, operator)
  when is_binary(operator) do
    delta = delta(operator)
    create_or_update_score(target, delta)
  end

  defp create_or_update_score(target, operator, reason_text) do
    score = create_or_update_score(target, operator)
    reason = create_reason(score, reason_text, operator)
    {score, reason}
  end

  defp delta("++") do
    1
  end

  defp delta("--") do
    -1
  end

  defp create_reason(score, reason_text, operator) do
    delta = delta(operator)
    {:ok, reason} = Repo.insert(%Reason{score_id: score.id, text: reason_text, delta: delta})
    reason
  end

  defp create_or_update_score(target, delta)
  when is_integer(delta) do
    case Query.by_target(target) do
      nil ->
        {:ok, score} = create_score(target, delta)
        score
      score ->
        {:ok, score} = update_score(score, delta)
        score
    end
  end

  defp update_score(score, delta) do
    %{score | value: (score.value + delta)}
    |> Repo.update
  end

  defp create_score(target, delta) do
    Repo.insert(%Score{target: target, value: delta})
  end

  defp process_text(text) do
    cond do
      results = Regex.run(~r/(.*)([\+\-][\+\-])\sfor\s(.*)/, text) ->
        [_, target, operator, reason_text] = results
        create_or_update_score(target, operator, reason_text)
        |> score_desc
      results = Regex.run(~r/(.*)([\+\-][\+\-])/, text) ->
        [_, target, operator] = results
        create_or_update_score(target, operator)
        |> score_desc
    end
  end
end
