class CreateUserCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :user_currencies do |t|
      t.integer :currency_id
      t.integer :user_id

      t.timestamps

      t.index [:currency_id, :user_id], unique: true
    end
  end
end
