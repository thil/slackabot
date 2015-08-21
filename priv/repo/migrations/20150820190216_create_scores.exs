defmodule Slackabot.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :target, :string, null: false
      add :value, :integer, null: false
      timestamps
    end
    create index(:scores, [:target], unique: true)
  end
end
