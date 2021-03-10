defmodule BowlingApi.Game.Get do
  import Ecto.Query

  alias BowlingApi.{Game, Game.Frame.Throw, Repo}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    throws_query = from t in Throw, order_by: t.inserted_at
    case Repo.get(Game, uuid) |> Repo.preload([throws: throws_query]) do
      nil -> {:error, "Game not found!"}
      game -> {:ok, game}
    end
  end
end
