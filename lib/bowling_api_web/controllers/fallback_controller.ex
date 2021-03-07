defmodule BowlingApiWeb.FallbackController do
  use BowlingApiWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BowlingApiWeb.ErrorView)
    |> render("400.json", %{result: result})
  end
end
