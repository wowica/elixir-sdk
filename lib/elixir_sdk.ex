defmodule ElixirSdk.UtxorpcClient do
  alias ElixirSdk.ChainSync

  defdelegate follow_tip, to: ChainSync
end
