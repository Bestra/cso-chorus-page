class RenameVoicePartDescription < ActiveRecord::Migration
  def change
    rename_column :voice_parts, :descripion, :description
  end
end
