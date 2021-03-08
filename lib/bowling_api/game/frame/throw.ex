defmodule BowlingApi.Game.Frame.Throw do
  use Ecto.Schema
  import Ecto.Changeset

  alias BowlingApi.Game.Frame

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "throws" do
    belongs_to(:frame, Frame)
    timestamps()
  end

  @required [:frame_id]

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
