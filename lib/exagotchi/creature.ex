defmodule Exagotchi.Creature do
  alias Exagotchi.Components.FeedingComponent
  alias Exagotchi.Components.AgingComponent

  ### Public API
  def spawn do
    {:ok, pid} = :gen_event.start_link
    :gen_event.add_handler(pid, FeedingComponent, 20)
    :gen_event.add_handler(pid, AgingComponent, 0)
    {:ok, pid}
  end

  def feed(pid) do
    notify(pid, :feed)
  end

  def get_stats(pid) do
    [
      food_capacity: FeedingComponent.get_capacity(pid),
      age: AgingComponent.get_age(pid)
    ]
  end

  defp notify(pid, event) do
    :gen_event.notify(pid, event)
  end
end
