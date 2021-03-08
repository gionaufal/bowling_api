defmodule BowlingApiWeb.FramesView do
  use BowlingApiWeb, :view

  alias BowlingApi.Game.Frame
  alias BowlingApiWeb.ThrowsView

  def render("frame.json", %{frames: %Frame{id: id, inserted_at: inserted_at, throws: throws}}) do
    %{
      frame_id: id,
      inserted_at: inserted_at,
      throws: render_many(throws, ThrowsView, "throw.json")
    }
  end
end
