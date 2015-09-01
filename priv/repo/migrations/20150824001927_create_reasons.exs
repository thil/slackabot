defmodule Slackabot.Repo.Migrations.CreateReasons do
  use Ecto.Migration

  def change do
    create table(:reasons) do
      add :score_id, references(:scores)
      add :text, :string, null: false
      add :delta, :integer, null: false
      timestamps
    end
  end
end
