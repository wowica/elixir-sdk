defmodule ElixirSdk.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_sdk,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:protobuf, "~> 0.12.0"},
      # Must use this fork of grpc
      {:grpc, github: "caike/grpc", ref: "e19165d9a92e8d06da2f25a11d49e3d610e25289"},
      {:castore, "~> 1.0"}
    ]
  end
end
