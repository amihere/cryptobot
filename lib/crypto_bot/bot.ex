defmodule CryptoBot.Bot do
  @bot :crypto_bot

  use ExGram.Bot,
    name: @bot,
    setup_commands: true

  use Tesla
  plug Tesla.Middleware.BaseUrl, "https://api.coingecko.com/api/v3"
  
  command("start")
  command("help", description: "Print the bot's help")
  command("tip", description: "Tip your waiter")
  
  middleware(ExGram.Middleware.IgnoreUsername)

  def bot(), do: @bot

  def handle({:command, :start, _msg}, context) do
    answer(context, "Hi!")
  end

  def handle({:command, :help, _msg}, context) do
    answer(context, "Here is your help: you can figure it out!!!")
  end
  
  def handle({:command, :list, _msg}, context) do
    {:ok, response} = get_tokens()
    answer(context, Jason.decode!(response.body) |> Enum.join("\n"))
  end
  
  def handle({:command, :tip, msg}, context) do
    {total, _ } = Integer.parse(msg.text)
    tip = total * 0.15
    answer(context, "#{tip}")
  end
  
  def get_tokens do
    get("/simple/supported_vs_currencies")
  end
  
  
end
