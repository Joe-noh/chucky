defmodule Chucky.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: {:global, __MODULE__})
  end

  def fact do
    GenServer.call({:global, __MODULE__}, :fact)
  end

  def init(_) do
    :rand.seed(:os.timestamp())

    facts = [
      "Chuck Norris's keyboard doesn't have a Ctrl key because nothing controls Chuck Norris.",
      "All arrays Chuck Norris declares are of infinite size, because Chuck Norris knows no bounds."
    ]

    {:ok, facts}
  end

  def handle_call(:fact, _from, facts) do
    {:reply, Enum.random(facts), facts}
  end
end
