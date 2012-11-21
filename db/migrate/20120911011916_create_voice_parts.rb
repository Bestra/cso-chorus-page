class CreateVoiceParts < ActiveRecord::Migration
  def change
    create_table :voice_parts do |t|
      t.string :descripion
      t.string :part
      t.string :abbreviation
      t.integer :section

      t.timestamps
    end
  end
end
