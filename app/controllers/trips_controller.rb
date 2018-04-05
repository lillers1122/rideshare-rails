class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show

    id = params[:id]
    @trip = Trip.find(id)
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @Trip.save
      redirect_to trips_path
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
    @trip.driver = Driver.find(params[:driver_id]).name
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    if @Trip.update(trip_params)
      redirect_to trips_path
    else
      render :edit
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip.destroy
      redirect_to trips_path
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end
end
