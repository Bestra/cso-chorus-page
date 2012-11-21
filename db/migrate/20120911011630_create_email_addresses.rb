class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses do |t|
      t.integer :member_id
      t.string :address
      t.boolean :publish

      t.timestamps
    end
  end
end
