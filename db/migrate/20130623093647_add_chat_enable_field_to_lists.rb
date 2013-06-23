class AddChatEnableFieldToLists < ActiveRecord::Migration
  def change
    add_column :lists, :chat_enabled, :boolean, :default => false
    add_column :lists, :chat_ref, :string
  end
end
