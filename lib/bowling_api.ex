defmodule BowlingApi do
  @moduledoc """
  BowlingApi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  defdelegate create_game(), to: BowlingApi.Game.Create, as: :call
end
