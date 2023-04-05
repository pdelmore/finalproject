class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.text :body
      t.integer :patient_id
      t.integer :user_id
      t.integer :service_id
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
