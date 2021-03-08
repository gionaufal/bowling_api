defmodule BowlingApiWeb.GamesController do
  use BowlingApiWeb, :controller

  alias BowlingApi.FrameCreator

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

    BowlingApi.fetch_game(id)
    |> handle_response(conn, "show.json", :ok)
  end

  defp handle_response({:ok, game}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, game: game)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error

  defp build_throw_params({:ok, game}, pins) do
    {:ok, frame} = FrameCreator.get_or_create_frame(game)
    %{
      frame_id: frame.id,
      pins: pins
    }
  end

  defp get_frame_id(game) do
    List.last(game.frames).id
  end
end
