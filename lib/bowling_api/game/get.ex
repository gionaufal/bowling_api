defmodule BowlingApi.Game.Get do
  alias BowlingApi.{Game, Repo}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Game, uuid) do
      nil -> {:error, "Game not found!"}
      game -> {:ok, game}
    end
  end
end
