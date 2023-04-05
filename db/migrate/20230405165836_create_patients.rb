class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone_number
      t.text :general_notes

      t.timestamps
    end
  end
end
