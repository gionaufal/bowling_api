defmodule BowlingApiWeb.GamesController do
  use BowlingApiWeb, :controller

  action_fallback BowlingApiWeb.FallbackController

  def create(conn, _params) do
    BowlingApi.create_game()
    |> handle_response(conn, "create.json", :created)
  end

  def show(conn, %{"id" => id}) do
    id
    |> BowlingApi.fetch_game()
    |> handle_response(conn, "show.json", :ok)
  end

  defp handle_response({:ok, game}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, game: game)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
