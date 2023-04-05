class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :title
      t.string :duration
      t.string :coverage
      t.string :price

      t.timestamps
    end
  end
end
