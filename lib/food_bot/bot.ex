defmodule FoodBot.Bot do
  @bot :ulele_bot

  use ExGram.Bot,
    name: @bot,
    setup_commands: true

  use Tesla
  plug(Tesla.Middleware.BaseUrl, "https://api.coingecko.com/api/v3")

  command("start")
  command("help", description: "Print the bot's help")
  command("random", description: "I want something to eat!")

  middleware(ExGram.Middleware.IgnoreUsername)

  def bot(), do: @bot

  def handle({:command, :start, _msg}, context) do
    answer(context, "Welcome to the Food Decider!")
  end

  def handle({:command, :help, _msg}, context) do
    answer(context, "Here is your help: you can figure it out!!!")
  end

  def handle({:command, :random, msg}, context) do
    answer(context, "Waakye All Day!")
  end

  def get_tokens do
    get("/simple/supported_vs_currencies")
  end
end
