class ShiftsController < ApplicationController
  SCOPE = "activerecord.errors.controllers.shift".freeze # Necessary to acces locales file

  def new
    if admin_user?
      @shift = Shift.new
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to home_path
    end
  end

  def create
    if admin_user?
      @shift = Shift.new(shift_params)
      create_shift @shift
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to home_path
    end
  end

  def show
    @shift = Shift.find_by_id(params["id"])
    if @shift.nil?
      redirect_to home_path
      return
    else
      @offsprings = @shift.offsprings
    end
  end

  def edit
    if admin_user?
      @shift = Shift.find_by_id(params[:id])
      return unless edit_shift @shift
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to request.referer || home_path
    end
  end

  def update
    if admin_user?
      @shift = Shift.find_by_id(params["id"])
      update_shift @shift
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to request.referer || home_path
    end
  end

  def destroy
    if admin_user?
      validate_destroy_shift
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to request.referer || home_path
    end
  end

  private

  def create_shift(_shi)
    if @shift.save
      flash[:success] = I18n.t("create_correct", scope: SCOPE)
      render 'new'
    else
      flash[:danger] = I18n.t("create_wrong", scope: SCOPE)
      redirect_to request.referer || new_shift_path
    end
  end

  def update_shift(shi)
    if shi.nil?
      flash[:danger] = I18n.t("shift_non-existing", scope: SCOPE)
      redirect_to request.referer || shifts_path
    else
      update_shift_attributes(@shift)
    end
  end

  def edit_shift(shi)
    if shi.nil?
      flash[:danger] = I18n.t("edit_wrong", scope: SCOPE)
      redirect_to request.referer || home_path
      return false
    end
    true
  end

  def validate_destroy_shift
    shift = Shift.find_by_id(params[:id])
    if shift.nil?
      flash[:danger] = I18n.t("shift_non-existing", scope: SCOPE)
      redirect_to home_path
    else
      destroy_shift shift
    end
  end

  def destroy_shift(shi)
    if shi.destroy
      flash[:success] = I18n.t("shift_destroy_correct", scope: SCOPE)
      redirect_to shifts_path
    else
      flash[:danger] = I18n.t("shift_destroy_wrong", scope: SCOPE)
      redirect_to home_path
    end
  end

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
    params.require(:shift).permit(:day_of_week, :start_time, :end_time, :room_id)
  end

  def admin_user?
    current_user.admin?
  end

  def access_control?
    ApplicationHelper.status_lock?
  end
end
