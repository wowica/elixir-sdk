defmodule ElixirSdkTest do
  use ExUnit.Case
  doctest ElixirSdk

  test "greets the world" do
    assert ElixirSdk.hello() == :world
  end
end
