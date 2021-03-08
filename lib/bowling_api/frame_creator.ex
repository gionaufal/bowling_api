defmodule BowlingApi.FrameCreator do
  alias BowlingApi.{Game, Game.Frame, Game.Frame.Throw}

  def get_or_create_frame(game) do
    throws_count = Enum.count(List.last(game.frames).throws)
    frame = cond do
      throws_count > 1 -> Frame.Create.call(%{game_id: game.id})
      true -> {:ok, List.last(game.frames)}
    end
  end
end
