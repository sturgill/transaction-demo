class CreateTransactionLocks < ActiveRecord::Migration
  def change
    create_table :transaction_locks, id: false do |t|
      t.string :name, null: false
    end
    add_index :transaction_locks, :name, unique: true
  end
end
