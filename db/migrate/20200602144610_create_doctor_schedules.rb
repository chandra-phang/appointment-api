class CreateDoctorSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :doctor_schedules do |t|
      t.integer :doctor_id, null: false
      t.integer :hospital_id, null: false
      t.integer :day_of_week, array: true
      t.string :start_time
      t.string :end_time

      t.timestamps
    end

    add_index :doctor_schedules, [:hospital_id, :doctor_id], unique: true
    add_foreign_key :doctor_schedules, :users, column: :doctor_id
    add_foreign_key :doctor_schedules, :hospitals
  end
end
