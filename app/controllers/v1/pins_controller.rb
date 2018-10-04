class V1::PinsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_v1_map
  before_action :set_v1_pin, only: [:show, :update, :destroy]

  # GET /v1/pins
  def index
    @v1_pins = @v1_map.pins

    render json: @v1_pins
  end

  # GET /v1/pins/1
  def show
    render json: @v1_pin
  end

  # POST /v1/pins
  def create
    @v1_pin = @v1_map.pins.new(v1_pin_params)

    if @v1_pin.save
      render json: @v1_pin, status: :created, location: v1_map_pin_url(id: @v1_pin)
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

    def set_v1_map
      @v1_map = V1::Map.find_by(slug: params[:map_slug])
    end

    def set_v1_pin
      @v1_pin = @v1_map.pins.find(params[:id])
    end

    def v1_pin_params
      params.require(:v1_pin).permit(:layer_id, :location, :context, :images).merge(map: @v1_map, user: current_user)
    end
end
