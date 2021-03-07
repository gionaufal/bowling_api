defmodule BowlingApiWeb.GamesController do
  use BowlingApiWeb, :controller

  action_fallback BowlingApiWeb.FallbackController

  def create(conn, _params) do
    BowlingApi.create_game()
    |> handle_response(conn)
  end

  defp handle_response({:ok, game}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", game: game)
  end

  defp handle_response({:error, _changeset} = error, _conn), do: error
end
