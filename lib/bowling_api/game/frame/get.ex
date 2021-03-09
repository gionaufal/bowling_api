defmodule BowlingApi.Game.Frame.Get do
  alias BowlingApi.{Game.Frame, Repo}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Frame, uuid) |> Repo.preload(:throws) do
      nil -> {:error, "Frame not found!"}
      game -> {:ok, game}
    end
  end
end
