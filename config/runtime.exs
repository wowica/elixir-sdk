import Config

config :elixir_sdk, ElixirSdk.FollowTip, api_key: System.fetch_env!("DMTR_API_KEY")
