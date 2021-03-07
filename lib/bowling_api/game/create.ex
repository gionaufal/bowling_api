defmodule BowlingApi.Game.Create do
  alias BowlingApi.{Game, Repo}

  def call() do
    Game.build()
    |> create_game()
  end

  defp create_game(struct), do: Repo.insert(struct)
end
