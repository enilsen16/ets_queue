defmodule ExQueue do
  use GenServer

  ## Client API
  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def find(name) do
    case :ets.lookup(:queue, name) do
      [{^name, queue}] -> {:ok, queue}
      [] -> :error
    end
  end

  def new(name) do
    GenServer.call(__MODULE__, {:new, name})
  end

  def add(name, item) do
    GenServer.call(__MODULE__, {:add, name, item})
  end

  def pop(name) do
    GenServer.call(__MODULE__, {:pop, name})
  end

  ## Server API
  def init(:ok) do
    {:ok, :ets.new(:queue, [:named_table, :protected])}
  end

  def handle_call({:new, name}, _from, table) do
    case find(name) do
      {:ok, name} ->
        {:reply, name, table}
      :error ->
        new_queue(table, name)
        {:reply, :queue.new, table}
    end
  end

  def handle_call({:add, name, item}, _from, table) do
    case find(name) do
      {:ok, queue} ->
        queue = :queue.in(item, queue)
        :ets.insert(table, {name, queue})
        {:reply, queue, table}
      :error ->
        {:reply, {:error, :queue_not_found}}
    end
  end

  def handle_call({:pop, name}, _from, table) do
    case find(name) do
      {:ok, queue} ->
        {{_value, item}, queue} = :queue.out(queue)
        :ets.insert(table, {name, queue})
        {:reply, item, table}
      :error ->
        {:reply, {:error, :queue_not_found}}
    end
  end

  ## Helpers
  defp new_queue(table, name) do
    :ets.insert(table, {name, :queue.new})
  end
end
