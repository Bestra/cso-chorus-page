class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :program_name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.boolean :publish_data
      t.integer :height
      t.date :date_joined
      t.integer :voice_part_id
      t.integer :folder_id
      t.string :photo_path
      t.integer :status_id

      t.timestamps
    end
  end
end
