defmodule Acl.Acl_context.Role do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:role, :string, autogenerate: false}

  schema "acl_roles" do
    field :parent, :string
    #field :role, :string, primary_key: true
    has_many :rules, Acl.Acl_context.Rule, foreign_key: :role
    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:role, :parent])
    |> validate_required([:role])
  end
end
