defmodule UI do
  def handler(pid) do
    case Exagotchi.Creature.alive?(pid) do
      true ->
        print_exagotchi_status(pid)
        print_message
        case handle_input(pid) do
          :ok -> handler(pid)
          _   ->
            IO.puts "exiting..."
        end
      false ->
        print_death_message
    end
  end

  defp print_message do
    IO.puts "What would you like to do?"
    IO.puts "a) age"
    IO.puts "f) feed"
    IO.puts "p) play"
  end

  defp print_exagotchi_status(pid) do
    age    = Exagotchi.Creature.get_stats(pid)[:age]
    hungry = Exagotchi.Creature.hungry?(pid)
    sad    = Exagotchi.Creature.sad?(pid)
    IO.puts "\n\n\n\n\n"
    IO.puts "Age: #{age} | Hungry? #{hungry} | Sad? #{sad}"
  end

  defp handle_input(pid) do
    IO.gets(:stdio, "> ") |> evaluate_input(pid)
  end

  defp evaluate_input(input, pid) when is_atom(input) do
    case input do
      :eof -> :exit
      _    -> unknown_input(pid)
    end
  end
  defp evaluate_input(input, pid) when is_binary(input) do
    case String.strip(input) do
      "a" -> Exagotchi.Creature.age(pid)
      "f" -> Exagotchi.Creature.feed(pid)
      "p" -> Exagotchi.Creature.play(pid)
      _   -> unknown_input(pid)
    end
    :ok
  end

  defp unknown_input(pid) do
    IO.puts "That's crazy talk and makes no sense, try again..."
    handle_input(pid)
  end

  defp print_death_message do
    IO.puts "You have killed your Exagotchi and should be ashamed.  Do better!"
  end
end

{:ok, pid} = Exagotchi.Creature.spawn
UI.handler(pid)
