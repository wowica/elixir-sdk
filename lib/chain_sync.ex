defmodule ElixirSdk.ChainSync do
  @moduledoc """
  Client for interacting with the Utxorpc.V1alpha.Sync.ChainSyncService.
  """

  alias Utxorpc.V1alpha.Cardano.Block
  alias Utxorpc.V1alpha.Sync.ChainSyncService.Stub
  alias Utxorpc.V1alpha.Sync.FollowTipRequest
  alias Utxorpc.V1alpha.Sync.FollowTipResponse

  defmodule ClientHeadersInterceptor do
    @moduledoc """
    Used for sending auth headers to server
    """
    @behaviour GRPC.Client.Interceptor

    @impl true
    def init(opts), do: opts

    @impl true
    def call(stream, req, next, opts) do
      metadata = Keyword.get(opts, :metadata, %{})
      new_stream = GRPC.Client.Stream.put_headers(stream, metadata)

      next.(new_stream, req)
    end
  end

  def follow_tip(intersect_refs \\ []) do
    with {:ok, channel} <- connect(),
         {:ok, stream} <- do_follow_tip(channel, intersect_refs) do
      Enum.each(stream, &handle_response/1)
    end
  end

  defp connect do
    GRPC.Stub.connect(host(),
      interceptors: [{ClientHeadersInterceptor, metadata: auth()}],
      # Must use Mint adapter instead of default Gun
      adapter: GRPC.Client.Adapters.Mint
    )
  end

  defp do_follow_tip(channel, intersect_refs) do
    request = %FollowTipRequest{intersect: intersect_refs}

    Stub.follow_tip(channel, request)
  end

  defp handle_response(
         {:ok,
          %FollowTipResponse{
            action: {:apply, %{chain: {:cardano, %Block{header: header} = _block}}}
          }}
       ) do
    IO.puts("Apply block: #{Base.encode16(header.hash) |> String.downcase()}")
  end

  defp handle_response(
         {:ok,
          %FollowTipResponse{
            action: {:undo, %{chain: {:cardano, %Block{header: header} = _block}}}
          }}
       ) do
    IO.puts("Undo block: #{Base.encode16(header.hash) |> String.downcase()}")
  end

  defp handle_response({:ok, %FollowTipResponse{action: {:reset, _block_ref}}}) do
    IO.puts("Reset to block ref:")
  end

  defp handle_response({:ok, %FollowTipResponse{action: nil} = response}) do
    IO.puts("No action #{inspect(response)}")
  end

  defp handle_response({:error, reason}) do
    IO.puts("Error, #{inspect(reason)}")
  end

  defp host, do: "https://preview.utxorpc-v0.demeter.run"

  defp auth do
    %{
      "dmtr-api-key": Application.get_env(:elixir_sdk, __MODULE__)[:api_key]
    }
  end
end
