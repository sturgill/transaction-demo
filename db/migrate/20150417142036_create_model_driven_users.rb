class CreateModelDrivenUsers < ActiveRecord::Migration
  def change
    create_table :model_driven_users do |t|
      t.string :username
      t.timestamps
    end

    add_index :model_driven_users, :username
  end
end
