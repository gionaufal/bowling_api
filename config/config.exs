# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bowling_api,
  ecto_repos: [BowlingApi.Repo]

# Configures the endpoint
config :bowling_api, BowlingApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pw3S3FM5nU0n2RvLfrD4rz4XvnSnbYx6naO0LN+jp0jyo98NDESFxalOBO9c/hQw",
  render_errors: [view: BowlingApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BowlingApi.PubSub,
  live_view: [signing_salt: "uvR7mY4a"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
