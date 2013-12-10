defmodule Exagotchi.Components.AgingComponent do
  ### Public API
  def get_age(entity) do
    :gen_event.call(entity, __MODULE__, :get_age)
  end

  ### GenEvent API
  def init(age // 0) do
    { :ok, age }
  end

  def handle_event(:age, age) do
    {:ok, age + 1}
  end
  def handle_event(_, age) do
    {:ok, age}
  end

  def handle_call(:get_age, age) do
    {:ok, age, age}
  end
end
