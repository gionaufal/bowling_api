defmodule BowlingApiWeb.ThrowsView do
  use BowlingApiWeb, :view

  alias BowlingApi.Game.Frame.Throw

  def render("throw.json", %{throws: %Throw{id: id, inserted_at: inserted_at, pins: pins}}) do
    %{
      throw_id: id,
      inserted_at: inserted_at,
      pins: pins
    }
  end
end
