defmodule BowlingApiWeb.GamesView do
  use BowlingApiWeb, :view

  alias BowlingApi.Game
  alias BowlingApi.Game.Frame.Throw
  alias BowlingApiWeb.FramesView

  def render("create.json", %{result: %Game{id: id, inserted_at: inserted_at}}) do
    %{
      message: "Game created!",
      game: %{
        id: id,
        inserted_at: inserted_at
      }
    }
  end

  def render("show.json", %{result: %Game{id: id, inserted_at: inserted_at, frames: frames} = game}) do
    %{
      id: id,
      inserted_at: inserted_at,
      frames: render_many(frames, FramesView, "frame.json"),
      score: Enum.reduce(game.throws, 0, fn throw, acc -> throw.pins + acc end)
    }
  end

  def render("new_throw.json", %{result: %Throw{id: id, pins: pins, inserted_at: inserted_at}}) do
    %{
      message: "Throw recorded!",
      throw: %{
        id: id,
        inserted_at: inserted_at,
        pins: pins
      }
    }
  end
end
