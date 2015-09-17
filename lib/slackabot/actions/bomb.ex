defmodule Slackabot.Actions.Bomb do
  alias Slackabot.Actions.ImageSearch

  def act(text, _) do
    [
      ImageSearch.act(text, nil),
      ImageSearch.act(text, nil),
      ImageSearch.act(text, nil),
      ImageSearch.act(text, nil)
    ]
  end
end
