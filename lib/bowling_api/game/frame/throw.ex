defmodule BowlingApi.Game.Frame.Throw do
  use Ecto.Schema
  import Ecto.Changeset

  alias BowlingApi.Game.Frame

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "throws" do
    field :pins, :integer, default: 0
    belongs_to(:frame, Frame)
    timestamps()
  end

  @required [:frame_id, :pins]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_number(:pins, less_than_or_equal_to: 10)
  end
end
