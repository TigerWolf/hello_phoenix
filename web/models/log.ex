defmodule HelloPhoenix.Log do
  use HelloPhoenix.Web, :model

  schema "logs" do
    field :amount, :integer
    has_many :log_activities, HelloPhoenix.LogActivity
    has_many :activities, through: [:log_activities, :activity]
    belongs_to :user, HelloPhoenix.User

    timestamps
  end

  @required_fields ~w(amount)
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
end
