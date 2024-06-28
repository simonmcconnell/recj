# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :recj, Oban,
  plugins: [
    Oban.Plugins.Lifeline,
    Oban.Plugins.Reindexer,
    # {Oban.Plugins.Reindexer, timezone: "Australia/Brisbane"},
    {Oban.Plugins.Pruner, max_age: :timer.hours(48)}
  ],
  repo: Recj.Repo,
  queues: [
    reports: [limit: 1],
    things: [limit: 4],
    default: [limit: 10]
  ]

config :recj,
  ecto_repos: [Recj.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :recj, RecjWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: RecjWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Recj.PubSub,
  live_view: [signing_salt: "wh4KSDDa"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
