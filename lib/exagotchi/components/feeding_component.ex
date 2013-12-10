defmodule Exagotchi.Components.FeedingComponent do
  ### Public API
  def get_capacity(entity) do
    :gen_event.call(entity, __MODULE__, :get_capacity)
  end

  ### GenEvent API
  def init(feeding_capacity // 0) do
    { :ok, feeding_capacity }
  end

  def handle_event(:feed, feeding_capacity) do
    {:ok, feeding_capacity + 1}
  end
  def handle_event(_, age) do
    {:ok, age}
  end

  def handle_call(:get_capacity, feeding_capacity) do
    {:ok, feeding_capacity, feeding_capacity}
  end
end
