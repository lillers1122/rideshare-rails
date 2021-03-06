class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    id = params[:id]
    @driver = Driver.find(id)
    @passengers = Passenger.all
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      redirect_to drivers_path
    else
      render :new
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])
  end

  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.update(driver_params)
      redirect_to drivers_path
    else
      render :edit
    end
  end

  def destroy
    id = params[:id]
    @driver = Driver.find(id)
    @driver.trips.delete_all

    if @driver.destroy
      redirect_to drivers_path
    end

  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
