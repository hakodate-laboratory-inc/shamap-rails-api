class V1::MapsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_v1_map, only: [:show, :update, :destroy]

  # GET /v1/maps
  def index
    @v1_maps = V1::Map.all

    render json: @v1_maps
  end

  # GET /v1/maps/1
  def show
    render json: @v1_map
  end

  # POST /v1/maps
  def create
    @v1_map = V1::Map.new(v1_map_params)

    if @v1_map.save
      render json: @v1_map, status: :created, location: @v1_map
    else
      render json: @v1_map.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/maps/1
  def update
    if @v1_map.update(v1_map_params)
      render json: @v1_map
    else
      render json: @v1_map.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/maps/1
  def destroy
    @v1_map.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_map
      @v1_map = V1::Map.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def v1_map_params
      params.require(:v1_map).permit(:title, :slug, :description)
    end
end
