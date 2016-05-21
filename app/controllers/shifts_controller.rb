class ShiftsController < ApplicationController
  before_action :admin_user?
  def show
    @shift=Shift.find_by_id(params["id"])
    if @shift==nil
      redirect_to home_path
    end
    @offsprings=@shift.offsprings
  end

  private

    def admin_user?
      unless current_user.admin?
        redirect_to home_path
      end
    end
end
