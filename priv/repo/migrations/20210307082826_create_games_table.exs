defmodule BowlingApi.Repo.Migrations.CreateGamesTable do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :uuid, primary_key: true
      timestamps()
    end
  end
end
