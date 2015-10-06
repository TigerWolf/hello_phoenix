defmodule HelloPhoenix.LogTest do
  use HelloPhoenix.ModelCase

  alias HelloPhoenix.Log

  @valid_attrs %{amount: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Log.changeset(%Log{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Log.changeset(%Log{}, @invalid_attrs)
    refute changeset.valid?
  end
end
