defmodule BowlingApi.Game.Frame.Create do
  alias BowlingApi.{Game.Frame, Repo}

  def call(params) do
    params
    |> Frame.build()
    |> handle_build()
  end

  defp handle_build({:ok, frame}), do: Repo.insert(frame)
  defp handle_build({:error, _frame} = error), do: error
end
