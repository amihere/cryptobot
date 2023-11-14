defmodule FoodBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    token = Application.fetch_env!(:ex_gram, :token)
    redis_url = Application.fetch_env!(:redix, :redis_url)
    children = [
      # Starts a worker by calling: CryptoBot.Worker.start_link(arg)
      # {CryptoBot.Worker, arg}
	    ExGram,
      FoodBot.FoodAgent,
	    {FoodBot.Bot, [method: :polling, token: token]},
	    {FoodBot.RedixLoader, redis_url}
	  ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FoodBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
