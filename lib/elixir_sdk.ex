defmodule ElixirSdk.UtxorpcClient do
  alias ElixirSdk.FollowTip

  def follow_tip, do: FollowTip.run()
end
