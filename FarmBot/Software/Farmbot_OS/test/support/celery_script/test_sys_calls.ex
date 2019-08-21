defmodule Farmbot.TestSupport.CeleryScript.TestSysCalls do
  @moduledoc """
  Stub implementation of CeleryScript SysCalls
  """

  @behaviour FarmbotCeleryScript.SysCalls
  use GenServer

  def checkout do
    case GenServer.start_link(__MODULE__, [], name: __MODULE__) do
      {:error, {:already_started, pid}} ->
        :ok = GenServer.call(pid, :checkout)
        {:ok, pid}

      {:ok, pid} ->
        :ok = GenServer.call(pid, :checkout)
        {:ok, pid}
    end
  end

  def handle(pid, fun) when is_function(fun, 2) do
    GenServer.call(pid, {:handle, fun})
  end

  @impl true
  def init([]) do
    {:ok, %{checked_out: nil, handler: nil}}
  end

  @impl true
  def handle_call(:checkout, {pid, _}, state) do
    {:reply, :ok, %{state | checked_out: pid}}
  end

  def handle_call({:handle, fun}, {pid, _}, %{checked_out: pid} = state) do
    {:reply, :ok, %{state | handler: fun}}
  end

  def handle_call({kind, args}, _from, %{handler: handler} = state)
      when is_function(handler, 2) do
    {:reply, {handler, kind, args}, state}
  end

  @impl true
  def log(_message) do
    :ok
  end

  @impl true
  def sequence_init_log(_message) do
    :ok
  end

  @impl true
  def sequence_complete_log(_message) do
    :ok
  end

  @impl true
  def coordinate(x, y, z) do
    %{x: x, y: y, z: z}
  end

  @impl true
  def nothing() do
    call({:nothing, []})
  end

  @impl true
  def set_servo_angle(pin_number, angle) do
    call({:set_servo_angle, [pin_number, angle]})
  end

  @impl true
  def set_pin_io_mode(pin_number, mode) do
    call({:set_pin_io_mode, [pin_number, mode]})
  end

  @impl true
  def install_first_party_farmware() do
    call({:install_first_party_farmware, []})
  end

  @impl true
  def point(type, id) do
    call({:point, [type, id]})
  end

  @impl true
  def move_absolute(x, y, z, speed) do
    call({:move_absolute, [x, y, z, speed]})
  end

  @impl true
  def get_current_x do
    call({:get_current_x, []})
  end

  @impl true
  def get_current_y do
    call({:get_current_y, []})
  end

  @impl true
  def get_current_z do
    call({:get_current_z, []})
  end

  @impl true
  def write_pin(pin_number, mode, value) do
    call({:write_pin, [pin_number, mode, value]})
  end

  @impl true
  def named_pin(type, id) do
    call({:named_pin, [type, id]})
  end

  @impl true
  def read_pin(number, mode) do
    call({:read_pin, [number, mode]})
  end

  @impl true
  def wait(millis) do
    call({:wait, [millis]})
  end

  @impl true
  def send_message(level, message, channels) do
    call({:send_message, [level, message, channels]})
  end

  @impl true
  def find_home(axis) do
    call({:find_home, [axis]})
  end

  @impl true
  def get_sequence(id) do
    call({:get_sequence, [id]})
  end

  @impl true
  def execute_script(name, args) do
    call({:execute_script, [name, args]})
  end

  @impl true
  def update_farmware(name) do
    call({:update_farmware, [name]})
  end

  @impl true
  def read_status do
    call({:read_status, []})
  end

  @impl true
  def set_user_env(key, val) do
    call({:set_user_env, [key, val]})
  end

  @impl true
  def sync do
    call({:sync, []})
  end

  @impl true
  def calibrate(axis) do
    call({:calibrate, [axis]})
  end

  @impl true
  def flash_firmware(package) do
    call({:flash_firmware, [package]})
  end

  @impl true
  def change_ownership(email, secret, server) do
    call({:change_ownership, [email, secret, server]})
  end

  @impl true
  def dump_info() do
    call({:dump_info, []})
  end

  @impl true
  def factory_reset(package) do
    call({:factory_reset, [package]})
  end

  @impl true
  def firmware_reboot do
    call({:firmware_reboot, []})
  end

  @impl true
  def power_off do
    call({:power_off, []})
  end

  @impl true
  def reboot do
    call({:reboot, []})
  end

  @impl true
  def resource_update(kind, id, params) do
    call({:resource_update, [kind, id, params]})
  end

  @impl true
  def check_update() do
    call({:check_update, []})
  end

  @impl true
  def emergency_lock() do
    call({:emergency_lock, []})
  end

  @impl true
  def emergency_unlock() do
    call({:emergency_unlock, []})
  end

  @impl true
  def get_toolslot_for_tool(id) do
    call({:get_toolslot_for_tool, [id]})
  end

  @impl true
  def home(axis, speed) do
    call({:home, [axis, speed]})
  end

  @impl true
  def zero(axis) do
    call({:zero, [axis]})
  end

  defp call(data) do
    {handler, kind, args} = GenServer.call(__MODULE__, data, :infinity)
    handler.(kind, args)
  end
end
