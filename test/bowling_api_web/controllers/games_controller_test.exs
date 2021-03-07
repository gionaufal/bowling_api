defmodule BowlingApiWeb.GamesControllerTest do
  use BowlingApiWeb.ConnCase

  describe "create/2" do
    test "creates a game", %{conn: conn} do
      response =
        conn
        |> post(Routes.games_path(conn, :create))
        |> json_response(:created)

      assert %{
        "game" => %{
          "id" => _id,
          "inserted_at" => _inserted_at,
        },
        "message" => "Game created!"
      } = response
    end
  end
end
