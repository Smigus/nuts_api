# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :nuts_api,
  ecto_repos: [NutsApi.Repo]

# Configures the endpoint
config :nuts_api, NutsApi.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4KustSr8LpSKA5VMV3u8KmlvRnVJuQweFKq/RN7z8AyHeS1W9D7kPJlGQFk0coDK",
  render_errors: [view: NutsApi.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NutsApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
