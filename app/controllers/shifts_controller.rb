class ShiftsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
  end

  def new
  end

  def create
  end

  def show
    @shift = Shift.find_by_id(params["id"])
    redirect_to home_path if @shift.nil?
    @offsprings = @shift.offsprings
  end

  def update
  end

  def destroy
  end
end
