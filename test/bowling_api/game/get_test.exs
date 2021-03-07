defmodule BowlingApi.Game.GetTest do
  use BowlingApi.DataCase

  alias BowlingApi.Game.{Create, Get}

  describe "call/1" do
    test "when given a valid and existing ID, it fetches a game" do
      {:ok, game} = Create.call()

      {:ok, response} = Get.call(game.id)

      assert game == response
    end

    test "when given an invalid ID, returns an error" do
      {:error, response} = Get.call("1234")

      assert response == "Invalid ID format!"
    end

    test "when given a valid but inexisting ID, returns an error" do
      Create.call()

      {:error, response} = Get.call("ca17a759-591a-4c1d-a295-5f63d11533e1")

      assert response == "Game not found!"
    end
  end
end
