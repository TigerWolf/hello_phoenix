defmodule HelloPhoenix.Log do
  use HelloPhoenix.Web, :model

  schema "logs" do
    field :amount, :integer
    belongs_to :activity, HelloPhoenix.Activity
    belongs_to :user, HelloPhoenix.User

    timestamps
  end

  @required_fields ~w(amount activity_id user_id)
  # TODO, FIXME: This is a security concern and users can craft requests to alter the date of new logs
  @optional_fields ~w(inserted_at)

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
    log.amount * activity_points(log.activity)
  end

  def activity_points(nil), do: 0
  def activity_points(activity), do: activity.points
end
