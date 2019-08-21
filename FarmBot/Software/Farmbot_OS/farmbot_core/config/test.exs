use Mix.Config

# must be lower than other timers
# To ensure other timers have time to timeout
config :farmbot_core, FarmbotCore.AssetMonitor, checkup_time_ms: 500

config :farmbot_core, FarmbotCore.AssetWorker.FarmbotCore.Asset.FarmEvent, checkup_time_ms: 1000

config :farmbot_core, FarmbotCore.AssetWorker.FarmbotCore.Asset.RegimenInstance,
  checkup_time_ms: 1000

config :farmbot_celery_script, FarmbotCeleryScript.SysCalls,
  sys_calls: Farmbot.TestSupport.CeleryScript.TestSysCalls

config :farmbot_core, FarmbotCore.FirmwareOpenTask, attempt_threshold: 0

config :farmbot_core, FarmbotCore.AssetWorker.FarmbotCore.Asset.FbosConfig,
  firmware_flash_attempt_threshold: 0
