defmodule BowlingApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BowlingApi.Repo,
      # Start the Telemetry supervisor
      BowlingApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BowlingApi.PubSub},
      # Start the Endpoint (http/https)
      BowlingApiWeb.Endpoint
      # Start a worker by calling: BowlingApi.Worker.start_link(arg)
      # {BowlingApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BowlingApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BowlingApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
