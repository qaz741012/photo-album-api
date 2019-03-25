class Photo < ApplicationRecord
  mount_uploader :file_location, PhotoUploader
end
