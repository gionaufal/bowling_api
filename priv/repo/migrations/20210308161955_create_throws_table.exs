defmodule BowlingApi.Repo.Migrations.CreateThrowsTable do
  use Ecto.Migration

  def change do
    create table(:throws, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :pins, :integer
      add :frame_id, references(:frames, type: :uuid, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
