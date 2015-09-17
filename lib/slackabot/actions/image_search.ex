defmodule Slackabot.Actions.ImageSearch do
  alias Utility.Random

  def act(%{text: text}) do
    image_url(text)
  end

  defp image_url(query) do
    "#{base_uri}#{params(query)}"
    |> HTTPotion.get
    |> process_response
  end

  defp process_response(%{status_code: 200, body: body}) do
    body
    |> to_string
    |> Poison.decode!
    |> extract_url
  end

  defp params(query) do
    %{ q: query, v: "1.0" } |> URI.encode_query
  end

  # defp params("boombot animate me" <> _, query) do
  #   %{ imgtype: "animated", q: query, v: "1.0" } |> URI.encode_query
  # end

  defp base_uri, do: "https://ajax.googleapis.com/ajax/services/search/images?"

  defp extract_url(%{"responseData" => %{"results" => items}}) do
    Random.seed(:os.timestamp)
    pos = Random.random(length(items))
    Enum.at(items, pos)["url"]
  end
end
