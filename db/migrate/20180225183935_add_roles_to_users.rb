class AddRolesToUsers < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE TYPE roles as ENUM ('admin', 'member');
    SQL

    add_column :users, :role, :roles, default: 'member'
  end

  def down
    remove_column :users, :role

    execute <<-SQL
      DROP TYPE roles
    SQL
  end
end
