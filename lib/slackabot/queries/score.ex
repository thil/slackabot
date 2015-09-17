defmodule Slackabot.Queries.Score do
  alias Slackabot.Repo
  import Ecto.Query, only: [from: 2]

  def by_target(target) do
    query = from s in Slackabot.Models.Score,
          where: s.target == ^target
    Repo.all(query)
    |> List.first
  end
end
