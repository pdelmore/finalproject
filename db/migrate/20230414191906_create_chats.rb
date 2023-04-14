class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.string :role
      t.string :content
      t.string :msg
      t.string :prompt_id

      t.timestamps
    end
  end
end
