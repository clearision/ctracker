class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code

      t.timestamps

      t.index :code, unique: true
    end
  end
end
