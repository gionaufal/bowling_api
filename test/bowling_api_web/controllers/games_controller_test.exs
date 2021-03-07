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

  describe "show/2" do
    test "when given a valid and existing ID, get a game", %{conn: conn} do
      {:ok, %BowlingApi.Game{id: id}} = BowlingApi.create_game()
      response =
        conn
        |> get(Routes.games_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
        "id" => ^id,
        "inserted_at" => _inserted_at,
        "score" => 0
      } = response
    end

    test "when given an invalid ID, returns error", %{conn: conn} do
      response =
        conn
        |> get(Routes.games_path(conn, :show, "1234"))
        |> json_response(400)

      assert %{"errors" => %{"detail" => "Invalid ID format!"}} = response
    end

    test "when given a valid but inexisting ID, returns error", %{conn: conn} do
      response =
        conn
        |> get(Routes.games_path(conn, :show, "ca17a759-591a-4c1d-a295-5f63d11533e4"))
        |> json_response(404)

      assert %{"errors" => %{"detail" => "Not Found"}} = response
    end
  end
end
