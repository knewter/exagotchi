defmodule ExagotchiTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = Exagotchi.Creature.spawn
    {:ok, creature: pid}
  end

  test "you can spawn a new exagotchi", meta do
    assert is_pid(meta[:creature])
  end

  test "you can feed an exagotchi", meta do
    [food_capacity: old_food_capacity, age: _age] = Exagotchi.Creature.get_stats(meta[:creature])
    assert :ok == Exagotchi.Creature.feed(meta[:creature])
    [food_capacity: new_food_capacity, age: _age] = Exagotchi.Creature.get_stats(meta[:creature])
    assert new_food_capacity == old_food_capacity + 1
  end

  test "you can get an exagotchi's stats", meta do
    starting_stats = [
      food_capacity: 20,
      age: 0
    ]
    assert starting_stats == Exagotchi.Creature.get_stats(meta[:creature])
  end
end
