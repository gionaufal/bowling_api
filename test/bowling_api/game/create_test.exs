defmodule BowlingApi.Game.CreateTest do
  use BowlingApi.DataCase

  alias BowlingApi.{Game, Repo}
  alias Game.Create

  describe "call/0" do
    test "it creates a game" do
      count_before = Repo.aggregate(Game, :count)

      response = Create.call()

      count_after = Repo.aggregate(Game, :count)

      assert {:ok, %Game{id: _id}} = response
      assert count_after == count_before + 1
    end
  end
end
