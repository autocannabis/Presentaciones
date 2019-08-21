require "spec_helper"

describe Devices::Sync do
  let(:user) { FactoryBot.create(:user) }
  let(:device) { user.device }

  TABLES = Set.new([
    :devices,
    :farm_events,
    :farmware_envs,
    :farmware_installations,
    :fbos_configs,
    :firmware_configs,
    :first_party_farmwares,
    :peripherals,
    :pin_bindings,
    :points,
    :regimens,
    :sensor_readings,
    :sensors,
    :sequences,
    :tools,
  ])

  it "is different this time!" do
    results = Devices::Sync.run!(device: device)
    expect(Set.new(results.keys)).to eq(TABLES)
  end
end
