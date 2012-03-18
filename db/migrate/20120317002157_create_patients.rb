class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.integer :id
      t.text :name
      t.text :address

      t.timestamps
    end
  end
end
