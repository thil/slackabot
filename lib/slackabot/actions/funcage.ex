defmodule Slackabot.Actions.Funcage do
  def act(_) do
    image_url
  end

  def image_url do
    HTTPotion.get(base_uri)
    |> process_response
  end

  defp process_response(%{status_code: 200, body: body}) do
    base_uri <> image_url(body)
  end

  defp base_uri, do: "http://www.funcage.com"

  defp image_url(body) do
    Regex.run(~r/img src=\"(.*)\" alt/, body)
    |> List.last
  end
end
