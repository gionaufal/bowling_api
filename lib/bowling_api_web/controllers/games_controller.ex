defmodule BowlingApiWeb.GamesController do
  use BowlingApiWeb, :controller

  alias BowlingApi.Game

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

  def new_throw(conn, %{"id" => id, "pins" => pins}) do
    id
    |> BowlingApi.fetch_game()
    |> build_throw_params(pins)
    |> BowlingApi.new_throw()
    |> handle_response(conn, "new_throw.json", :created)
  end

  defp handle_response({:ok, game}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, result: game)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error

  defp build_throw_params({:ok, game}, pins) do
    Game.get_or_create_frame(game)
    |> handle_get_or_create_frame(pins)
  end

  defp handle_get_or_create_frame({:ok, frame}, pins) do
    %{
      frame_id: frame.id,
      pins: pins
    }
  end

  defp handle_get_or_create_frame({:error, _changeset} = error, _pins), do: error
end
