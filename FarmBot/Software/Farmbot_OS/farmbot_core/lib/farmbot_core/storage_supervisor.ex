defmodule FarmbotCore.StorageSupervisor do
  @moduledoc """
  Top-level supervisor for REST resources (Asset), configs and the logger.
  """

  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, [name: __MODULE__])
  end

  def init([]) do
    children = [
      FarmbotCore.Logger.Supervisor,
      FarmbotCore.Config.Supervisor,
      FarmbotCore.Asset.Supervisor
    ]
    Supervisor.init(children, [strategy: :one_for_one])
  end
end
