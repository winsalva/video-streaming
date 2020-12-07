# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :my_tube,
  ecto_repos: [MyTube.Repo]

# Configures the endpoint
config :my_tube, MyTubeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XpGxpC+oqd3QK7WP67Mpy5x4mkWDNth42Sg4mVaWE69SFwYGuwcui01AGtBm2/r2",
  render_errors: [view: MyTubeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MyTube.PubSub,
  live_view: [signing_salt: "Qj8wk6tN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
