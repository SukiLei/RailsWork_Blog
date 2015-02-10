class Article < ActiveRecord::Base
	has_many :comments
=begin
	RAILS_ROOT = 'D:/ruby/RailsWork/blog'
	def self.image_preview(file)
    file_name = UUID.random_create.to_s + File.extname(file.original_filename)
    file_path = "#{RAILS_ROOT}/public/upload_images/temp_image/"
    FileUtils.mkdir_p(file_path) unless File.exist?(file_path)
    real_path = file_path + file_name
    File.open(real_path, 'wb') do |f|
      f.write(file.read)
    end
    return file_name
  end
 def self.get_image(name)
  "/upload_images/temp_image/#{name}"
 end
=end
end
