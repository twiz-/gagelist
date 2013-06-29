class AddFirebaseTokenFieldToLists < ActiveRecord::Migration
  def change
    add_column :lists, :chat_auth_token, :string
  end
end
