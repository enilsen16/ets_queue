defmodule ExQueueTest do
  use ExUnit.Case

  setup do
    ExQueue.create()
    :ok
  end

  test "add a value to the queue" do
    ExQueue.insert("hioperator")
    assert ExQueue.EtsHelper.lookup() == [{:saved_queue, {["hioperator"], []}}]
  end

  test "pop a value from the queue" do
    ExQueue.insert("hioperator")
    assert ExQueue.EtsHelper.lookup() == [{:saved_queue, {["hioperator"], []}}]

    ExQueue.insert("taylor-stitch")
    assert ExQueue.EtsHelper.lookup() == [saved_queue: {["taylor-stitch"], ["hioperator"]}]

    assert ExQueue.pop() == "hioperator"
    assert ExQueue.pop() == "taylor-stitch"
  end
end
