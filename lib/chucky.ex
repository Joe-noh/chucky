defmodule Chucky do
  use Application
  require Logger

  def start(:normal, _args) do
    Logger.info("Application is started on #{node()}")
    do_start()
  end

  def start({:takeover, old_node}, _args) do
    Logger.info("#{node()} is taking over #{old_node}")
    do_start()
  end

  def start({:failover, old_node}, _args) do
    Logger.info("#{old_node} is failing over to #{node()}")
    do_start()
  end

  defp do_start do
    import Supervisor.Spec

    children = [
      worker(Chucky.Server, [])
    ]
    opts = [
      strategy: :one_for_one,
      name: {:global, Chucky.Supervisor}
    ]

    Supervisor.start_link(children, opts)
  end

  def fact do
    Chucky.Server.fact()
  end
end
