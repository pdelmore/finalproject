class DropColumnInChat < ActiveRecord::Migration[6.0]
  def change
    remove_column :chats, :msg
  end
end
