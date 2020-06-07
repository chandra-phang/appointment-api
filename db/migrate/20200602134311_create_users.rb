class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :role
      t.string :state
      t.string :gender
      t.date :date_of_birth
      t.string :encrypted_password, null: false, default: ""
      t.text :tokens

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
