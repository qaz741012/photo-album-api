json.extract! photo, :id, :title, :description, :file_location, :date, :created_at, :updated_at
json.url photo_url(photo, format: :json)
