class CreatePhoneTypes < ActiveRecord::Migration
  def change
    create_table :phone_types do |t|
      t.string :description
      t.string :abbreviation

      t.timestamps
    end
  end
end
