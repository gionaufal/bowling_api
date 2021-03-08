defmodule BowlingApi.Repo.Migrations.CreateFramesTable do
  use Ecto.Migration

  def change do
    create table(:frames, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :game_id, references(:games, type: :uuid, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
