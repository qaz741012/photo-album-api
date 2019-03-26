class Photo < ApplicationRecord
  mount_uploader :file_location, PhotoUploader

  validates :title, presence: true
end
