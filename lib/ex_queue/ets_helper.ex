defmodule ExQueue.EtsHelper do
  @moduledoc """
  Documentation for ExQueue.
  """

  @doc """
  create an ets table with the name `:queue`
  Returns a table id

  # Example
  iex(1)> ExQueue.EtsHelper.create()
  :queue
  """
  def create() do
    :ets.new(:queue, [:set, :protected, :named_table, read_concurrency: true])
  end

  @doc """
  inserts into the table

  Example
  iex(1)> queue = {[],[]}
  iex(1)> ExQueue.EtsHelper.create()
  iex(1)> ExQueue.EtsHelper.insert(queue)
  true
  """
  def insert(queue) do
    :ets.insert(:queue, {:saved_queue, queue})
  end

  @doc """
  lookup value via the atom name `:saved_queue`

  Example
  iex(1)> queue = {[],[]}
  iex(1)> ExQueue.EtsHelper.create()
  iex(1)> ExQueue.EtsHelper.insert(queue)
  iex(1)> ExQueue.EtsHelper.lookup()
  [{:saved_queue, {[], []}}]
  """
  def lookup() do
    :ets.lookup(:queue, :saved_queue)
  end
end
