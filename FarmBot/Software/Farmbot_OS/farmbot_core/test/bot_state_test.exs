defmodule FarmbotCore.BotStateTest do
  use ExUnit.Case
  alias FarmbotCore.BotState

  describe "bot state pub/sub" do
    test "subscribes to bot state updates" do
      {:ok, bot_state_pid} = BotState.start_link([], [])
      _initial_state = BotState.subscribe(bot_state_pid)
      :ok = BotState.set_user_env(bot_state_pid, "some_key", "some_val")
      assert_receive {BotState, %Ecto.Changeset{valid?: true}}
    end

    test "invalid data doesn't get dispatched" do
      {:ok, bot_state_pid} = BotState.start_link([], [])
      _initial_state = BotState.subscribe(bot_state_pid)
      result = BotState.report_disk_usage(bot_state_pid, "this is invalid")
      assert match?({:error, %Ecto.Changeset{valid?: false}}, result)
      refute_receive {BotState, %Ecto.Changeset{valid?: true}}
    end
  end

  describe "pins" do
    test "sets pin data" do
      {:ok, bot_state_pid} = BotState.start_link([], [])
      :ok = BotState.set_pin_value(bot_state_pid, 9, 1)
      :ok = BotState.set_pin_value(bot_state_pid, 10, 1)
      :ok = BotState.set_pin_value(bot_state_pid, 11, 0)

      assert %{pins: %{9 => %{value: 1}, 10 => %{value: 1}, 11 => %{value: 0}}} =
               BotState.fetch(bot_state_pid)
    end
  end
end
