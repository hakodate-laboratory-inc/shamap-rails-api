class V1::LayersController < ApplicationController
  before_action :set_v1_layer, only: [:show, :update, :destroy]

  # GET /v1/layers
  def index
    @v1_layers = V1::Layer.all

    render json: @v1_layers
  end

  # GET /v1/layers/1
  def show
    render json: @v1_layer
  end

  # POST /v1/layers
  def create
    @v1_layer = V1::Layer.new(v1_layer_params)

    if @v1_layer.save
      render json: @v1_layer, status: :created, location: @v1_layer
    else
      render json: @v1_layer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/layers/1
  def update
    if @v1_layer.update(v1_layer_params)
      render json: @v1_layer
    else
      render json: @v1_layer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/layers/1
  def destroy
    @v1_layer.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_v1_layer
      @v1_layer = V1::Layer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def v1_layer_params
      params.require(:v1_layer).permit(:map_id, :name, :slug)
    end
end
