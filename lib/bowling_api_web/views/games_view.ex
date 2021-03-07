defmodule BowlingApiWeb.GamesView do
  use BowlingApiWeb, :view

  alias BowlingApi.Game

  def render("create.json", %{game: %Game{id: id, inserted_at: inserted_at}}) do
    %{
      message: "Game created!",
      game: %{
        id: id,
        inserted_at: inserted_at
      }
    }
  end

  def render("show.json", %{game: %Game{id: id, inserted_at: inserted_at}}) do
    %{
      id: id,
      inserted_at: inserted_at,
      score: 0
    }
  end
end
