defmodule Chucky.Application do
  use Application
  require Logger

  def start(type, _args) do
    import Supervisor.Spec, warn: false

    case type do
      :normal ->
        Logger.info("Application is started on #{node()}")

      {:takeover, old_node} ->
        Logger.info("#{node()} is taking over #{old_node}")

      {:failover, old_node} ->
        Logger.info("#{old_node} is failing over to #{node()}")
    end

    children = [
      worker(Chucky.Server, [])
    ]
    opts = [
      strategy: :one_for_one,
      name: {:global, Chucky.Supervisor}
    ]

    Supervisor.start_link(children, opts)
  end
end
