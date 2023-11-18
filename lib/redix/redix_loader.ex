defmodule FoodBot.RedixLoader do
  require Logger

  @moduledoc """
  Documentation for `RedixLoader`.
  """
  use GenServer
  import Redix

  def start_link(redis_url) do
    GenServer.start_link(
      __MODULE__,
      redis_url,
      name: __MODULE__
    )
  end

  def custom_blocking(command_list) do
    GenServer.call(__MODULE__, {:custom, command_list})
  end

  def custom(command_list) do
    GenServer.cast(__MODULE__, {:custom, command_list})
  end

  def stop do
    GenServer.stop(__MODULE__)
  end

  # Server
  @impl true
  def init(redis_url) do
    connect_redis(redis_url)
  end

  defp connect_redis(redis_url) do
    Logger.info("establish connextion to redix")
    Redix.start_link(redis_url, name: :redix)
  end

  @impl true
  def handle_call({:custom, command_list}, _from, conn) do
    case Redix.command(conn, command_list) do
      {:ok, value} ->
        {:reply, value, conn}

      _ ->
        {:reply, nil, conn}
    end
  end

  @impl true
  def handle_cast({:custom, command_list}, conn) do
    Redix.command(conn, command_list)
    {:noreply, conn}
  end

  @impl true
  def terminate(_reason, conn) do
    Logger.info("disconnext from redix")
    Redix.stop(conn)
    :ok
  end
end
