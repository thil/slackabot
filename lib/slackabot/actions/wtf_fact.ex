defmodule Slackabot.Actions.WtfFact do
  alias Slackabot.Slack
  alias Utility.Random

  @base_uri "http://wtffunfact.com/page/"

  def act(message, _) do
    Slack.msg(%{message | text: image_url})
  end

  def image_url do
    HTTPotion.get(url)
    |> process_response
  end

  defp process_response(%{status_code: 200, body: body}) do
    image_path(body)
  end

  defp url do
    @base_uri <> page
  end

  defp page do
    Random.seed(:os.timestamp)
    Random.random(800)
    |> to_string
  end

  defp image_path(body) do
    Random.seed(:os.timestamp)
    Regex.scan(~r/img src=\"(.*)\"\sclass/, body)
    |> Random.sample
    |> List.last
  end
end
