defmodule BowlingApi.Game do
  use Ecto.Schema

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "games" do
    timestamps()
  end

  def build() do
    %__MODULE__{}
  end
end
