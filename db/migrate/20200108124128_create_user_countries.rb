class CreateUserCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :user_countries do |t|
      t.integer :country_id
      t.integer :user_id

      t.timestamps

      t.index [:country_id, :user_id], unique: true
    end
  end
end
