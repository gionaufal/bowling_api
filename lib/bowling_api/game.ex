defmodule BowlingApi.Game do
  use Ecto.Schema

  alias BowlingApi.Game.Frame

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "games" do
    has_many(:frames, Frame)
    has_many :throws, through: [:frames, :throws]
    timestamps()
  end

  def build() do
    %__MODULE__{}
  end
end
