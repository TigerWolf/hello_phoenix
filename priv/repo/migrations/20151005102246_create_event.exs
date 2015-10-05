defmodule HelloPhoenix.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:event) do
      add :name, :string
      add :start_date, :datetime
      add :end_date, :datetime

      timestamps
    end

  end
end
