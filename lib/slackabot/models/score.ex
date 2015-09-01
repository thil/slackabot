defmodule Slackabot.Models.Score do
  use Ecto.Model

  schema "scores" do
    field :target, :string
    field :value, :integer

    timestamps
  end
end
