class Api::V1::PhotosController < ApiController
  before_action :authenticate_user!, only: [:show, :create, :update, :destroy]

  def index
    @photos = Photo.all
    render json: {
      data: @photos.map do |photo|
        {
          id: photo.id,
          title: photo.title,
          date: photo.date,
          description: photo.description,
          file_location: {
            url: photo.file_location.url
          }
        }
      end
    }
  end

  def show
    photo = Photo.find_by_id(params[:id])
    if !photo
      render json: {
        message: "Can't find the photo."
      }, status: 400
    end and return

    render json: {
      id: photo.id,
      title: photo.title,
      date: photo.date,
      description: photo.description,
      file_location: {
        url: photo.file_location.url
      }
    }
  end

  def create
    photo = Photo.new(photo_params)
    if photo.save
      render json: {
        message: "Photo created successfully!",
        result: photo
      }
    else
      render json: {
        errors: photo.errors
      }
    end
  end

  def update
    photo = Photo.find_by_id(params[:id])
    if !photo
      render json: {
        message: "Can't find the photo."
      }, status: 400
    end and return

    if photo.update(photo_params)
      render json: {
        message: "Photo updated successfully!",
        result: photo
      }
    else
      render json: {
        errors: photo.errors
      }
    end
  end

  def destroy
    photo = Photo.find_by_id(params[:id])
    if !photo
      render json: {
        message: "Can't find the photo."
      }, status: 400
    end and return

    if photo.destroy
      render json: {
        message: "Photo deleted successfully!",
        result: photo
      }
    else
      render json: {
        errors: photo.errors
      }
    end
  end

  private

  def photo_params
    params.permit(:title, :description, :date, :file_location)
  end

end
