defmodule ExQueue do
  @moduledoc """
  Documentation for ExQueue.
  """

  @doc """
  create an ets table with the name `:queue`
  Returns a table id

  # Example
  iex(1)> ExQueue.create()
  :queue
  """
  def create() do
    :ets.new(:queue, [:set, :protected, :named_table])
  end

  @doc """
  inserts into the table

  Example
  iex(1)> queue = {[],[]}
  iex(1)> ExQueue.create()
  iex(1)> ExQueue.insert(queue)
  true
  """
  def insert(queue) do
    :ets.insert(:queue, {:saved_queue, queue})
  end

  @doc """
  update value in the table

  Example
  iex(1)> queue = {[],[]}
  iex(1)> ExQueue.create()
  iex(1)> ExQueue.insert(queue)
  iex(1)> ExQueue.update({[1], []})
  true
  """
  def update(queue) do
    :ets.insert(:queue, {:saved_queue, queue})
  end

  @doc """
  lookup value via the atom name `:saved_queue`

  Example
  iex(1)> queue = {[],[]}
  iex(1)> ExQueue.create()
  iex(1)> ExQueue.insert(queue)
  iex(1)> ExQueue.lookup()
  [{:saved_queue, {[], []}}]
  """
  def lookup() do
    :ets.lookup(:queue, :saved_queue)
  end
end
