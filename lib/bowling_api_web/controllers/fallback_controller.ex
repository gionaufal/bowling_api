defmodule BowlingApiWeb.FallbackController do
  use BowlingApiWeb, :controller

  def call(conn, {:error, "Game not found!"}) do
    conn
    |> put_status(:not_found)
    |> put_view(BowlingApiWeb.ErrorView)
    |> render("404.json")
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BowlingApiWeb.ErrorView)
    |> render("400.json", %{result: result})
  end
end
