defmodule FoodBot.FoodAgent do
  use Agent

  def start_link(data_key) do
    Agent.start_link(
      fn -> data_key end,
      name: __MODULE__
    )
  end

  def get() do
    Agent.get(__MODULE__, fn state ->
      FoodBot.RedixLoader.custom_blocking(["LRANGE", state, "0", "-1"]) |> Enum.random()
    end)
  end
end
