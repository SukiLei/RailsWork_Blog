class Article < ActiveRecord::Base
  has_many :comments
  has_many :supports
  mount_uploader :picture, PictureUploader
end
