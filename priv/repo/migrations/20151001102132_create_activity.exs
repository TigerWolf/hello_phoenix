defmodule HelloPhoenix.Repo.Migrations.CreateActivity do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :name, :string
      add :points, :integer
      add :event_id, :integer

      timestamps
    end

  end
end
