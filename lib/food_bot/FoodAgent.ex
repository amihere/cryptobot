defmodule FoodBot.FoodAgent do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(
      fn ->
        initial_value ++
          [
            "Waakye",
            "Jollof",
            "Dokono",
            "Banku",
            "Boba",
            "Fancy",
            "Fufu Time",
            "Attieke with Tilly",
            "Ampesie",
            "Angwa moo",
            "Abolo",
            "Omo Tuo",
            "Tuo Zafi",
            "Kokonte",
            "Roasted Plantain",
            "Red Red",
            "Kebab",
            "Kontomire with rice/plantain",
            "Fonfom",
            "Fried Rice",
            "GOB 3",
            "Grilled Chicken",
            "Goat Stew",
            "Fried Yam And Pork",
            "OMT (one man thousand)"
          ]
      end,
      name: __MODULE__
    )
  end

  def get() do
    Agent.get(__MODULE__, fn state -> state |> Enum.random() end)
  end
end
