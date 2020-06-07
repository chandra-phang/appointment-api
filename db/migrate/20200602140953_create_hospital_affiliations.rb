class CreateHospitalAffiliations < ActiveRecord::Migration[5.2]
  def change
    create_table :hospital_affiliations do |t|
      t.integer :hospital_id, null:false
      t.integer :doctor_id, null:false

      t.timestamps null: false
    end

    add_index :hospital_affiliations, [:hospital_id, :doctor_id], unique: true
    add_foreign_key :hospital_affiliations, :hospitals
    add_foreign_key :hospital_affiliations, :users, column: :doctor_id
  end
end
