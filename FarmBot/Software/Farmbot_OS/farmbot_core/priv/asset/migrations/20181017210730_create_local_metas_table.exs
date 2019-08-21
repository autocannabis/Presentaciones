defmodule FarmbotCore.Asset.Repo.Migrations.CreateLocalMetasTable do
  use Ecto.Migration

  def change do
    create table("local_metas") do
      add(:status, :string)
      add(:table, :string)
      add(:monitor, :boolean, default: true)
      add(:asset_local_id, :binary_id)
    end

    create(unique_index("local_metas", [:table, :asset_local_id]))
  end
end
