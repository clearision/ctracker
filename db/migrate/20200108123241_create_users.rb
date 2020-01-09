class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :authentication_token

      t.timestamps

      t.index :authentication_token, unique: true
    end
  end
end
