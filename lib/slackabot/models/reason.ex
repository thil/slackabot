defmodule Slackabot.Models.Reason do
  use Ecto.Model

  schema "reasons" do
    belongs_to :score, Score
    field :text, :string
    field :delta, :integer

    timestamps
  end
end
