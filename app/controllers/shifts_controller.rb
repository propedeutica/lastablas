class ShiftsController < ApplicationController
  SCOPE = "activerecord.errors.controllers.shift".freeze # Necessary to acces locales file
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:show]

  def new
    @shift = Shift.new
  end

  def create
    debugger
    @shift = Shift.new(shift_params)
    @shift.room = Room.find_by_id(params[:shift][:room])
    if @shift.save
      flash[:success] = I18n.t("create_correct", scope: SCOPE)
      render 'new'
    else
      flash[:danger] = I18n.t("create_wrong", scope: SCOPE)
      redirect_to request.referer || new_shift_path
    end
  end

  def show
    if user_signed_in? || admin_signed_in? # authenticate user or admin
      @shift = Shift.find_by_id(params["id"])
      redirect_to home_path if @shift.nil?
      @offsprings = @shift.offsprings
    else
      redirect_to new_admin_session_path
    end
  end

  def edit
    @shift = Shift.find_by_id(params[:id])
    if @shift.nil?
      flash[:danger] = I18n.t("edit_wrong", scope: SCOPE)
      redirect_to request.referer || home_path
      return
    end
  end

  def update
    @shift = Shift.find_by_id(params["id"])
    if @shift.nil?
      flash[:danger] = I18n.t("shift_non-existing", scope: SCOPE)
      redirect_to request.referer || shifts_path
    else
      update_shift_attributes(@shift)
    end
  end

  def destroy
  end

  private

  def update_shift_attributes(s)
    if s.update_attributes(shift_params)
      flash[:success] = I18n.t("update_correct", scope: SCOPE)
      render 'edit'
      return
    end
    flash[:danger] = I18n.t("update_wrong", scope: SCOPE)
    redirect_to request.referer || shifts_path
  end

  def shift_params
    params.require(:shift).permit(:day_of_week, :start_time, :end_time)
  end
end
