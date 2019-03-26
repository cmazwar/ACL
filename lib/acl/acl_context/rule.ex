defmodule Acl.Acl_context.Rule do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:action, :string, autogenerate: false, null: true, default: nil}

  schema "acl_rules" do

    field :condition, :integer, default: 1
    field :where_cond, :string, default: nil
    field :where_value, :string, default: nil
    field :where_field, :string, default: nil
    field :permission, :integer,  null: true, default: 1
    field :role, :string,  primary_key: true
    belongs_to :res, Acl.Acl_context.Res,  references: :id, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(rule, attrs) do
    rule
    |> cast(attrs, [:action, :permission, :allowed, :res, :role, :condition])
    |> validate_required([:res, :role])
  end
end
