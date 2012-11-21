require 'csv'
namespace :db do
  desc "Read the members  .tsv file in /app/assets/"

  def csv_to_table(file_path,table)
      puts "Populating #{table} from #{file_path}"
    CSV.foreach("#{file_path}", headers: true, col_sep: "\t") do |row|
      this_row = row.to_hash
      this_item =table.new(row.to_hash)
      this_item.id = this_row['id']
#      puts this_item.id
      this_item.save
      #puts row.to_hash
    end
  end

  task populate_members: :environment do
    csv_to_table('app/assets/legacy_csv_data/members.tsv',Member)
    csv_to_table('app/assets/legacy_csv_data/folders.tsv',Folder)
    csv_to_table('app/assets/legacy_csv_data/status_codes.tsv',MemberStatus)
    csv_to_table('app/assets/legacy_csv_data/voice_parts.tsv',VoicePart)
    csv_to_table('app/assets/legacy_csv_data/email_addresses.tsv', EmailAddress)
    csv_to_table('app/assets/legacy_csv_data/phone_numbers.tsv',PhoneNumber)
    csv_to_table('app/assets/legacy_csv_data/phone_types.tsv',PhoneType)
  end
end

