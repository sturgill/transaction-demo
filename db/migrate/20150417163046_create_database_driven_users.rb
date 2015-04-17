class CreateDatabaseDrivenUsers < ActiveRecord::Migration
  def change
    create_table :database_driven_users do |t|
      t.string :username, null: false
      t.timestamps
    end

    add_index :database_driven_users, :username, unique: true
  end
end
