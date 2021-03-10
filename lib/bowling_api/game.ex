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
    throws_count = case Enum.any?(game.frames) do
      false -> 0
      true -> Enum.count(List.last(game.frames).throws)
    end

    last_frame = List.last(game.frames)
    cond do
      throws_count == 0 -> Frame.Create.call(%{game_id: game.id})
      throws_count > 1 or Frame.strike?(last_frame) -> Frame.Create.call(%{game_id: game.id})
      true -> {:ok, List.last(game.frames)}
    end
  end

  def score(game) do
    Enum.reduce(game.frames, 0, fn frame, acc -> Frame.score(frame) + acc end)
  end
end
