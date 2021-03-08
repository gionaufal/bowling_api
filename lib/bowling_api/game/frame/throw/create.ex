defmodule BowlingApi.Game.Frame.Throw.Create do
  alias BowlingApi.{Game.Frame.Throw, Repo}

  def call(params) do
    params
    |> Throw.build()
    |> handle_build()
  end

  defp handle_build({:ok, throw}), do: Repo.insert(throw)
  defp handle_build({:error, _throw} = error), do: error
end
