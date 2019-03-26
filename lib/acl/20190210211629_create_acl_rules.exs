defmodule Acl.Repo.Migrations.CreateAclRules do
  use Ecto.Migration

  def change do
    create table(:acl_rules, primary_key: false) do
      add :role, references(:acl_roles, column: :role, type: :string, on_delete: :delete_all)
      add :res_id, references(:acl_res, column: :id, type: :id, on_delete: :delete_all)
      add :action, :string, default: nil
      add :permission, :int, default: 1
      add :condition, :int, default: 1
      add :where_field, :string, default: nil
      add :where_value, :string, default: nil
      add :where_cond, :string, default: nil
      timestamps()
    end

    create index(:acl_rules, [:res_id])
    create index(:acl_rules, [:role])
    create index(:acl_rules, [:role, :res_id, :action])


  end
end
