class CampersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_response
rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found_response
  
  def index
    render json: Camper.all, status: :ok
  end

  def show
    camper = Camper.find(params[:id])
    render json: camper, serializer: CamperActivitySerializer, status: :ok
  end

  def create
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
  end

  private

  def camper_params
    params.permit(:name, :age)
  end

  def render_unprocessable_response(invalid)
    render json: { errors: ["validation errors"] }, status: :unprocessable_entity
  end

  def camper_not_found_response
    render json: { error: "Camper not found" }, status: :not_found
  end

end
