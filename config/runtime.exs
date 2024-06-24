import Config

config :elixir_sdk, ElixirSdk.ChainSync, api_key: System.fetch_env!("DMTR_API_KEY")

config :grpc, GRPC.Client.Adapters.Mint, transport_opts: []
