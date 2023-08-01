defmodule FoodBotTest do
  use ExUnit.Case
  doctest FoodBot

  test "greets the world" do
    assert FoodBot.hello() == :world
  end
end
