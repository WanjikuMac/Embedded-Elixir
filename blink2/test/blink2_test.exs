defmodule Blink2Test do
  use ExUnit.Case
  doctest Blink2

  test "greets the world" do
    assert Blink2.hello() == :world
  end
end
