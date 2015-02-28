class ChangeDefaultValueOfRoleForUsers < ActiveRecord::Migration
  def change
  end

  def up
    change_column_default(:users, :role, 'regular')
  end

  def down
    change_column_default(:users, :role, nil)
  end
end
