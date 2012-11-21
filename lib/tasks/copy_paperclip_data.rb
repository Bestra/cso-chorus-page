desc "Copy paperclip data"
task :copy_paperclip_data => :environment do
  @members = Member.all
  @members.each do |member|
      filename = "app/assets/images/Pics/#{member.id}.jpg"
      if File.exists? filename
        image = File.new filename
        member.photo = image
        puts "Update member #{member.id} photo"
        member.save
        image.close
      end
    end
end

