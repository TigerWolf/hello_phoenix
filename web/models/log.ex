defmodule HelloPhoenix.Log do
  use HelloPhoenix.Web, :model

  schema "logs" do
    field :amount, :integer
    belongs_to :activity, HelloPhoenix.Activity
    belongs_to :user, HelloPhoenix.User

    timestamps
  end

  @required_fields ~w(amount activity_id user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def points(log) do
    log.amount * log.activity.points
  end
end
