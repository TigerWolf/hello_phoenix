defmodule HelloPhoenix.Repo.Migrations.AddAnnouncementToEvent do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :announcement, :text
    end
  end
end
