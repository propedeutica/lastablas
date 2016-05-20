class ShiftsController < ApplicationController
  def show
    @shift=Shift.find_by_id(params["id"])
    if @shift==nil
      redirect_to home_path
    end
    @offsprings=@shift.offsprings
  end
end
