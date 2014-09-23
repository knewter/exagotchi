defmodule Exagotchi.Components.MoodComponent do
  ### Public API
  def get_mood(entity) do
    :gen_event.call(entity, __MODULE__, :get_mood)
  end

  ### GenEvent API
  def init(mood_capacity \\ 0) do
    { :ok, mood_capacity }
  end

  def handle_event(:play, mood_capacity) do
    {:ok, mood_capacity + 3}
  end
  def handle_event(:age, mood_capacity) do
    {:ok, mood_capacity - 1}
  end
  def handle_event(_, mood_capacity) do
    {:ok, mood_capacity}
  end

  def handle_call(:get_mood, mood_capacity) do
    {:ok, mood_capacity, mood_capacity}
  end
end
