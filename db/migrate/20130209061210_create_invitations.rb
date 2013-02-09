class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
    
      t.integer :invited_by
      t.integer :invited_for_id
      t.string :invited_for_type
      t.string :token
      t.datetime :accepted_at
      t.string :email

      t.timestamps
    end
  end
end
