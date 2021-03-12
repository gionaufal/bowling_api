defmodule BowlingApiWeb.GamesControllerTest do
  use BowlingApiWeb.ConnCase

  alias BowlingApi.{Game, Repo}

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

    test "returns a score, frames and throws", %{conn: conn} do
      {:ok, %BowlingApi.Game{id: id} = game} = BowlingApi.create_game()
      {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))
      frame_id = frame.id
      BowlingApi.new_throw(%{frame_id: frame_id, pins: 10})

      response =
        conn
        |> get(Routes.games_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
        "id" => ^id,
        "inserted_at" => _,
        "score" => 10,
        "frames" =>  [
          %{
            "frame_id" => ^frame_id,
            "inserted_at" => _,
            "score" => 10,
            "throws" => [%{"inserted_at" => _, "pins" => 10, "throw_id" => _}]
          }]
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

  describe "new_throw/2" do
    test "creates first throw", %{conn: conn} do
      {:ok, %BowlingApi.Game{id: id}} = BowlingApi.create_game()

      response =
        conn
        |> post(Routes.games_path(conn, :new_throw, id), %{pins: 10})
        |> json_response(:created)

      assert %{
        "throw" => %{
          "id" => _id,
          "inserted_at" => _inserted_at,
          "pins" => 10
        },
        "message" => "Throw recorded!"
      } = response
    end

    test "returns error after if more than 10 pins are sent", %{conn: conn} do
      {:ok, %BowlingApi.Game{id: id}} = BowlingApi.create_game()

      response =
        conn
        |> post(Routes.games_path(conn, :new_throw, id), %{pins: 11})
        |> json_response(400)

      assert %{
        "errors" => %{
          "detail" => %{"pins" => [
            "Total of pins in a frame can't be greater than 10",
            "must be less than or equal to 10"]
          }}} == response
    end

    test "returns error after 10th frame ends", %{conn: conn} do
      {:ok, %BowlingApi.Game{id: id} = game} = BowlingApi.create_game()

      Enum.each(0..19, fn _ ->
        {:ok, frame} = Game.get_or_create_frame(game |> Repo.preload(:throws))
        BowlingApi.new_throw(%{frame_id: frame.id, pins: 4})
      end)

      response =
        conn
        |> post(Routes.games_path(conn, :new_throw, id), %{pins: 10})
        |> json_response(400)

      assert %{
        "errors" => %{
          "detail" => %{
            "game_id" => ["Game is over!"]
          }}} == response
    end
  end
end
