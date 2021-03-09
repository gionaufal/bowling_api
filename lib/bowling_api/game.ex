defmodule BowlingApi.Game do
  use Ecto.Schema

  alias BowlingApi.Game.Frame

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "games" do
    has_many(:frames, Frame)
    has_many :throws, through: [:frames, :throws]
    timestamps()
  end

  def build() do
    %__MODULE__{}
  end

  def get_or_create_frame(game) do
    throws_count = Enum.count(List.last(game.frames).throws)
    frame = cond do
      throws_count > 1 -> Frame.Create.call(%{game_id: game.id})
      true -> {:ok, List.last(game.frames)}
    end
  end
end
