class CreateCountryCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :country_currencies do |t|
      t.integer :country_id
      t.integer :currency_id

      t.timestamps

      t.index [:country_id, :currency_id], unique: true
    end
  end
end
