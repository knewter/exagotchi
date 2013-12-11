defmodule Exagotchi.Creature do
  alias Exagotchi.Components.FeedingComponent
  alias Exagotchi.Components.AgingComponent
  alias Exagotchi.Components.MoodComponent

  ### Public API
  def spawn do
    {:ok, pid} = :gen_event.start_link
    :gen_event.add_handler(pid, FeedingComponent, 20)
    :gen_event.add_handler(pid, MoodComponent, 20)
    :gen_event.add_handler(pid, AgingComponent, 0)
    {:ok, pid}
  end

  def feed(pid) do
    notify(pid, :feed)
  end

  def play(pid) do
    notify(pid, :play)
  end

  def age(pid) do
    notify(pid, :age)
  end

  def alive?(pid) do
    get_stats(pid)[:food_capacity] > 0
  end

  def dead?(pid) do
    !alive?(pid)
  end

  def hungry?(pid) do
    get_stats(pid)[:food_capacity] < 10
  end

  def sad?(pid) do
    get_stats(pid)[:mood_capacity] < 10
  end

  def get_stats(pid) do
    [
      food_capacity: FeedingComponent.get_capacity(pid),
      mood_capacity: MoodComponent.get_mood(pid),
      age: AgingComponent.get_age(pid)
    ]
  end

  ### Private bits...

  defp notify(pid, event) do
    case alive?(pid) do
      true -> :gen_event.notify(pid, event)
      false -> :cant_notify_too_dead
    end
  end
end
