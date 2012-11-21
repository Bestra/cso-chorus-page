class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.integer :member_id
      t.string :number
      t.integer :phone_type_id
      t.boolean :publish

      t.timestamps
    end
  end
end
