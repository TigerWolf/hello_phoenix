defmodule HelloPhoenix.User do
  use HelloPhoenix.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :crypted_password, :string
    field :captain_preference, :boolean
    field :name, :string
    field :admin, :boolean
    field :recovery_hash, :string

    timestamps

    belongs_to :team, HelloPhoenix.Team
    has_many :logs, HelloPhoenix.User
  end

  @required_fields ~w(email captain_preference name)
  @optional_fields ~w(admin team_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "passwords do not match")
  end

  # TODO: probably should be in controller or elsewhere
  def find_by_recovery_hash(hash) do
    try do
      query = from u in HelloPhoenix.User, where: u.recovery_hash == ^hash
      HelloPhoenix.Repo.one query
    rescue
      e in Postgrex.Error -> PostgresErrorHandler.handle_error(__MODULE__, e)
    end
  end

  # TODO: probably should be in controller or elsewhere
  def find_by_email(email) do
    try do
      query = from u in HelloPhoenix.User, where: u.email == ^email
      HelloPhoenix.Repo.one query
    rescue
      e in Postgrex.Error -> PostgresErrorHandler.handle_error(__MODULE__, e)
    end
  end

  # TODO: probably should be in controller or elsewhere
  def change_password(user, hash) do
    user = %{ user | recovery_hash: nil, crypted_password: hash}
    HelloPhoenix.Repo.update(user)
  end


end
