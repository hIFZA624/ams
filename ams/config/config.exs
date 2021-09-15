# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ams,
  ecto_repos: [Ams.Repo]

# Configures the endpoint
config :ams, AmsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "62LJ71/PLP4dxryKiBVIASfQjOfU2286OBBFsK24+t/1AlpzzaCKS2Xzf3YGpAh8",
  render_errors: [view: AmsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ams.PubSub,
  live_view: [signing_salt: "+bctGdb/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#configuration for guardian
config :ams, Ams.Accounts.Guardian,
       issuer: "ams",
       secret_key: "O8SCINSSQaKbUHKpXkAZzPmCUvUsoMb7Kj+Hyy6dzVoQN6Vj7ybbQ9FQ+IldGlRZ"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason



config :kaffy,
       otp_app: :ams,
       ecto_repo: Ams.Repo,
       router: AmsWeb.Router,
       admin_title: "Tanbits Accounts",
       admin_logo: "/images/logo.png",
       admin_logo_mini: "/images/logo_mini.png",
       extensions: [
         Ams.Kaffy.Extension
       ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
