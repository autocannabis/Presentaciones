defmodule FarmbotCore.Config.Repo.Migrations.AddFirmwareFlashSetting do
  use Ecto.Migration
  import FarmbotCore.Config, only: [update_config_value: 4]
  import FarmbotCore.Config.MigrationHelpers

  def change do
    create_settings_config("firmware_needs_flash", :bool, true)
  end
end
