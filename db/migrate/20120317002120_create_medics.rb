class CreateMedics < ActiveRecord::Migration
  def change
    create_table :medics do |t|
      t.integer :id
      t.text :name
      t.text :department

      t.timestamps
    end
  end
end
