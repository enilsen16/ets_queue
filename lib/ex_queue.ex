defmodule ExQueue do
  @moduledoc """
  Documentation for ExQueue.
  """
  alias ExQueue.EtsHelper

  @doc """
  Inserts an empty queue into the ets table
  """
  def create() do
    EtsHelper.create()

    :queue.new
    |> EtsHelper.insert
  end

  @doc """
  Inserts a value into a queue
  """
  def insert(value) do
    [{:saved_queue, queue}] = EtsHelper.lookup
    queue = :queue.in(value, queue)
    EtsHelper.insert(queue)
  end

  @doc """
  Pop off the queue
  """
  def pop() do
    [{:saved_queue, queue}] = EtsHelper.lookup()
    {{_value, item}, old_queue} = :queue.out(queue)
    case EtsHelper.insert(old_queue) do
      true ->
        item
      false ->
        :error
    end
  end
end
