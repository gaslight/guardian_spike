defmodule GuardianSpike.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt

  schema "users" do
    field :birthday, :date
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :reference_id, :string
    field :serial_number, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :first_name, :last_name, :reference_id, :birthday, :serial_number, :password])
    |> validate_required([:email, :first_name, :last_name, :password ])
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  defp put_password_hash(changeset), do: changeset

end
