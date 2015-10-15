defmodule HelloPhoenix.Repo.Migrations.EmailUnique do
  use Ecto.Migration

  def up do
    alter table(:users) do
      modify :email, :string, unique: true, required: true
      modify :crypted_password, :string, required: true
    end

    create unique_index(:users, [:email])
  end

  def down do
    alter table(:users) do
      modify :email, :string
      modify :crypted_password, :string
    end

  end
end
