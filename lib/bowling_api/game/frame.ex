defmodule BowlingApi.Game.Frame do
  use Ecto.Schema
  import Ecto.Changeset

  alias BowlingApi.Game

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "frames" do
    belongs_to(:game, Game)
    has_many(:throws, Game.Frame.Throw)
    timestamps()
  end

  @required [:game_id]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required)
    |> validate_required(@required)
  end
end
