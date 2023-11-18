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
  # command("experiment", description: "experiment")

  middleware(ExGram.Middleware.IgnoreUsername)

  def handle({:command, :start, _msg}, context) do
    answer(context, "Welcome to the Food Decider!")
  end

  def handle({:command, :help, _msg}, context) do
    answer(context, "Here is your help: you can figure it out!!!")
  end

  def handle({:command, :random, _msg}, context) do
    food = FoodBot.FoodAgent.get

    answer(context, food)
  end

  # def handle({:command, :experiment, _msg}, context) do
  #   IO.inspect(context)
  #
  #   reply = %ExGram.Model.ReplyKeyboardMarkup{keyboard: [["goat"], ["chicken"], ["gob3"]]}
  #
  #   case ExGram.send_message(context.chat.id, "Waakye Baby!", reply_markup: reply) do
  #     {:ok, msg} -> IO.inspect(msg)
  #     {:error, err} -> IO.inspect(err)
  #   end
  # end

  def get_tokens do
    get("/simple/supported_vs_currencies")
  end
end
