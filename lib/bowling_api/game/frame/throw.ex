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
    |> validate_frame_total()
  end

  defp validate_frame_total(changeset) do
    {:ok, frame} = Frame.Get.call(get_field(changeset, :frame_id))
    frame_total = frame.throws
      |> Enum.reduce(0, fn throw, acc -> throw.pins + acc end)

    validate_change(changeset, :pins, fn _, value ->
      cond do
        Frame.last?(frame) -> []
        (value + frame_total) > 10 -> [pins: "Total of pins in a frame can't be greater than 10"]
        true -> []
      end
    end)
  end
end
