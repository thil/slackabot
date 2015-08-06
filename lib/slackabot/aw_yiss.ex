defmodule Slackabot.AwYiss do
  alias Slackabot.WebsocketClient

  def handle(sock, channel, "aw yiss" <> msg) do
    url = generate(msg)
    WebsocketClient.send_event(sock, url, channel)
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
