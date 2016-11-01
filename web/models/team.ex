defmodule HelloPhoenix.Team do
  use HelloPhoenix.Web, :model

  schema "teams" do
    field :name, :string
    belongs_to :event, HelloPhoenix.Event
    belongs_to :captain, HelloPhoenix.User
    has_many :users, HelloPhoenix.User

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(captain_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def total_points(team) do
    users = Enum.reduce(team.users, 0, fn(users, count) ->
      count = Enum.reduce(users.logs, 0, &(HelloPhoenix.Log.points(&1) + &2))
    end)
  end
end
