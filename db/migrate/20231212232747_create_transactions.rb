class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.decimal :value
      t.text :info
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
