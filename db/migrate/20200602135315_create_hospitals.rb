class CreateHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitals do |t|
      t.string :name, null: false
      t.string :state
      t.text :address

      t.timestamps null: false
    end

    add_index :hospitals, :name
  end
end
