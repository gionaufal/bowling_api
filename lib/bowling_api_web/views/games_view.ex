defmodule BowlingApiWeb.GamesView do
  use BowlingApiWeb, :view

  alias BowlingApi.Game
  alias BowlingApiWeb.FramesView

  def render("create.json", %{game: %Game{id: id, inserted_at: inserted_at}}) do
    %{
      message: "Game created!",
      game: %{
        id: id,
        inserted_at: inserted_at
      }
    }
  end

  def render("show.json", %{game: %Game{id: id, inserted_at: inserted_at, frames: frames} = game}) do
    %{
      id: id,
      inserted_at: inserted_at,
      frames: render_many(frames, FramesView, "frame.json"),
      score: Enum.reduce(game.throws, 0, fn throw, acc -> throw.pins + acc end)
    }
  end
end
