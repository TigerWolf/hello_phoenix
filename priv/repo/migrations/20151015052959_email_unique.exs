defmodule HelloPhoenix.Repo.Migrations.EmailUnique do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :email, :string, unique: true
    end
  end
end
