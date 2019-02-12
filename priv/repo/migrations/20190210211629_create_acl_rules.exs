defmodule Acl.Repo.Migrations.CreateAclRules do
  use Ecto.Migration

  def change do
    create table(:acl_rules, primary_key: false) do
      add :role, references(:acl_roles, column: :role, type: :string, on_delete: :delete_all)
      add :res, references(:acl_res, column: :res, type: :string, on_delete: :delete_all)
      add :action, :string, default: nil
      add :permission, :string, default: nil
      add :allowed, :boolean, default: false, null: false


      timestamps()
    end

    create index(:acl_rules, [:res])
    create index(:acl_rules, [:role])
    create index(:acl_rules, [:role, :res, :action, :permission])
  end
end
