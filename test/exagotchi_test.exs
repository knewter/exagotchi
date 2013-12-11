defmodule ExagotchiTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = Exagotchi.Creature.spawn
    {:ok, creature: pid}
  end

  test "you can spawn a new exagotchi", meta do
    assert is_pid(meta[:creature])
  end

  test "you can get an exagotchi's stats", meta do
    starting_stats = [
      food_capacity: 20,
      mood_capacity: 20,
      age: 0
    ]
    assert starting_stats == Exagotchi.Creature.get_stats(meta[:creature])
  end

  test "you can feed an exagotchi", meta do
    [food_capacity: old_food_capacity, mood_capacity: old_mood_capacity, age: _age] = Exagotchi.Creature.get_stats(meta[:creature])
    assert :ok == Exagotchi.Creature.feed(meta[:creature])
    [food_capacity: new_food_capacity, mood_capacity: new_mood_capacity, age: _age] = Exagotchi.Creature.get_stats(meta[:creature])
    assert new_food_capacity == old_food_capacity + 1
  end

  test "an exagotchi uses a food per aging cycle", meta do
    [food_capacity: old_food_capacity, mood_capacity: old_mood_capacity, age: old_age] = Exagotchi.Creature.get_stats(meta[:creature])
    assert :ok == Exagotchi.Creature.age(meta[:creature])
    [food_capacity: new_food_capacity, mood_capacity: new_mood_capacity, age: new_age] = Exagotchi.Creature.get_stats(meta[:creature])
    assert new_food_capacity == old_food_capacity - 1
    assert new_age == old_age + 1
  end

  test "an exagotchi dies if its food capacity gets to 0", meta do
    [food_capacity: original_food_capacity, mood_capacity: original_mood_capacity, age: _] = Exagotchi.Creature.get_stats(meta[:creature])
    Enum.each((1..original_food_capacity), fn(_) -> Exagotchi.Creature.age(meta[:creature]) end)
    assert false == Exagotchi.Creature.alive?(meta[:creature])
    assert true == Exagotchi.Creature.dead?(meta[:creature])
  end

  test "an exagotchi is hungry if its food capacity gets under 10", meta do
    assert false == Exagotchi.Creature.hungry?(meta[:creature])
    [food_capacity: original_food_capacity, mood_capacity: original_mood_capacity, age: _] = Exagotchi.Creature.get_stats(meta[:creature])
    times_to_age_til_hunger = (-1 * (10 - original_food_capacity)) + 1
    Enum.each((1..times_to_age_til_hunger), fn(_) -> Exagotchi.Creature.age(meta[:creature]) end)
    assert true == Exagotchi.Creature.hungry?(meta[:creature])
  end

  test "you can play with an exagotchi", meta do
    [food_capacity: old_food_capacity, mood_capacity: old_mood_capacity, age: _age] = Exagotchi.Creature.get_stats(meta[:creature])
    assert :ok == Exagotchi.Creature.play(meta[:creature])
    [food_capacity: new_food_capacity, mood_capacity: new_mood_capacity, age: _age] = Exagotchi.Creature.get_stats(meta[:creature])
    assert new_mood_capacity == old_mood_capacity + 3
  end

  test "an exagotchi uses a mood per aging cycle", meta do
    [food_capacity: old_food_capacity, mood_capacity: old_mood_capacity, age: old_age] = Exagotchi.Creature.get_stats(meta[:creature])
    assert :ok == Exagotchi.Creature.age(meta[:creature])
    [food_capacity: new_food_capacity, mood_capacity: new_mood_capacity, age: new_age] = Exagotchi.Creature.get_stats(meta[:creature])
    assert new_mood_capacity == old_mood_capacity - 1
    assert new_age == old_age + 1
  end


end
