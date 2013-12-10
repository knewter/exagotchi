defmodule UI do
  def handler(pid) do
    case Exagotchi.Creature.alive?(pid) do
      true ->
        print_exagotchi_status(pid)
        print_message
        handle_input(pid)
        handler(pid)
      false ->
        print_death_message
    end
  end

  defp print_message do
    IO.puts "What would you like to do?"
    IO.puts "a) age"
    IO.puts "f) feed"
  end

  defp print_exagotchi_status(pid) do
    age = Exagotchi.Creature.get_stats(pid)[:age]
    hungry = Exagotchi.Creature.hungry?(pid)
    IO.puts "\n\n\n\n\n"
    IO.puts "Age: #{age} | Hungry? #{hungry}"
  end

  defp handle_input(pid) do
    input = IO.gets(:stdio, "> ")
    case String.strip(input) do
      "a" -> Exagotchi.Creature.age(pid)
      "f" -> Exagotchi.Creature.feed(pid)
    end
  end

  defp print_death_message do
    IO.puts "You have killed your Exagotchi and should be ashamed.  Do better!"
  end
end

{:ok, pid} = Exagotchi.Creature.spawn
UI.handler(pid)
