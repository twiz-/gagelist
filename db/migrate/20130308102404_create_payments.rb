class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.string :stripe_token
      t.decimal :amount, :precision => 4, :scale => 2
      t.string :email
      t.string :stripe_customer_id
      
      t.timestamps
    end
  end
end
