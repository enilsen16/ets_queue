defmodule ExQueueTest do
  use ExUnit.Case

  test "create a new queue" do
    ExQueue.start_link
    assert ExQueue.new(:saved_queue) == {[], []}
  end

  test "adds to the queue, then removes" do
    ExQueue.start_link
    ExQueue.new(:saved_queue)

    ExQueue.add(:saved_queue, "hioperator")
    ExQueue.add(:saved_queue, "google")
    assert ExQueue.find(:saved_queue) == {:ok, {["google"], ["hioperator"]}}

    ExQueue.pop(:saved_queue)
    assert ExQueue.find(:saved_queue) == {:ok, {[], ["google"]}}
  end
end
