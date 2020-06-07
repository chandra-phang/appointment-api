class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :doctor_id, null: false
      t.integer :patient_id, null: false
      t.integer :hospital_id, null: false
      t.string :start_at
      t.string :end_at

      t.timestamps
    end

    add_foreign_key :appointments, :hospitals
    add_foreign_key :appointments, :users, column: :doctor_id
    add_foreign_key :appointments, :users, column: :patient_id
  end
end
