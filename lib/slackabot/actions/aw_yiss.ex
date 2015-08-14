defmodule Slackabot.Actions.AwYiss do
  alias Slackabot.Slack

  def act(message, text) do
    Slack.msg(message.channel, generate(text))
  end

  def generate(msg) do
    text = Poison.encode!(%{phrase: msg})
    HTTPotion.post("http://awyisser.com/api/generator", [body: text, headers: ["Content-Type": "application/json"]])
    |> process_response
  end

  defp process_response(%{status_code: 200, body: body}) do
    body
    |> to_string
    |> Poison.decode!
    |> extract_url
  end

  defp extract_url(%{"link" => link}), do: link
end
