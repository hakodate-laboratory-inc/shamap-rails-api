class V1::PinsController < ApplicationController
  before_action :set_v1_pin, only: [:show, :update, :destroy]

  # GET /v1/pins
  def index
    @v1_pins = V1::Pin.all

    render json: @v1_pins
  end

  # GET /v1/pins/1
  def show
    render json: @v1_pin
  end

  # POST /v1/pins
  def create
    @v1_pin = V1::Pin.new(v1_pin_params)

    if @v1_pin.save
      render json: @v1_pin, status: :created, location: @v1_pin
    else
      render json: @v1_pin.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/pins/1
  def update
    if @v1_pin.update(v1_pin_params)
      render json: @v1_pin
    else
      render json: @v1_pin.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/pins/1
  def destroy
    @v1_pin.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_pin
      @v1_pin = V1::Pin.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def v1_pin_params
      params.require(:v1_pin).permit(:map_id, :layer_id, :user_id, :location, :context)
    end
end
