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
  @max_frame_count 10
  @max_pins_count 10

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_number_of_frames()
  end

  def strike?(frame) do
    List.first(frame.throws).pins == @max_pins_count
  end

  def spare?(frame) do
    Enum.count(frame.throws) == 2 &&
      Enum.reduce(frame.throws, 0, fn throw, acc -> throw.pins + acc end) == @max_pins_count
  end

  def score(frame) do
    {:ok, game} = fetch_game(frame.game_id)
    cond do
      last?(frame) -> base_score(frame)
      strike?(frame) -> score_next(game, throw_index(game, List.first(frame.throws)),  2) + base_score(frame)
      spare?(frame) -> score_next(game, throw_index(game, List.last(frame.throws)), 1) + base_score(frame)
      true -> base_score(frame)
    end
  end

  def last?(frame) do
    {:ok, game} = fetch_game(frame.game_id)
    Enum.find_index(game.frames, fn f -> f == frame end) == @max_frame_count - 1
  end

  def allow_new_throw?(frame) do
    throws_count = Enum.count(frame.throws)
    cond do
      last?(frame) and strike_or_spare?(frame) and throws_count < 3 -> true
      throws_count > 1 or strike?(frame) -> false
      throws_count < 2 -> true
    end
  end

  defp strike_or_spare?(frame) do
    strike?(frame) or spare?(frame)
  end

  defp base_score(frame) do
    Enum.reduce(frame.throws, 0, fn throw, acc -> throw.pins + acc end)
  end

  defp score_next(game, throw_index, next_throws_count) do
    Enum.slice(game.throws, (throw_index + 1)..(throw_index + next_throws_count))
    |> Enum.reduce(0, fn throw, acc -> throw.pins + acc end)
  end

  defp fetch_game(game_id) do
    Game.Get.call(game_id)
  end

  defp throw_index(game, throw) do
    Enum.find_index(game.throws, fn t -> t == throw end)
  end

  defp validate_number_of_frames(changeset) do
    {:ok, game} = fetch_game(get_field(changeset, :game_id))
    validate_change(changeset, :game_id, fn _, _ ->
      case Enum.count(game.frames) >= @max_frame_count do
        true -> [game_id: "Game is over!"]
        _ -> []
      end
    end)
  end
end
