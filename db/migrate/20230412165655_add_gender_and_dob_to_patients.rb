class AddGenderAndDobToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :gender, :string
    add_column :patients, :dob, :date
  end
end
