class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :id
      t.datetime :begin_time
      t.datetime :end_time
      t.integer :medic_id
      t.integer :patient_id

      t.timestamps
    end
  end
end
