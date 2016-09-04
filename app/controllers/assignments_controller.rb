class AssignmentsController < ApplicationController
  SCOPE = "activerecord.errors.controllers.assignment".freeze
  def new
    @offspring = Offspring.find_by_id(params[:format])
    @rooms = Room.all
  end

  def create
    access_control? ? create_assignment : flash[:alert] = I18n.t("admin_locked_create", scope: SCOPE)
    redirect_to root_url
  end

  def destroy
    of = Offspring.find_by_id(params["id"])
    of.shift = nil
    of.save
    redirect_to new_assignment_path(of)
  end

  private

  def access_control?
    if current_user.admin?
      true
    else
      !ApplicationHelper.status_lock?
    end
  end

  def create_assignment
    Offspring.transaction do
      of = Offspring.lock.find_by_id(params["format"])
      of.shift = Shift.find_by_id(params["shift"])
      of.save
      flash[:success] = I18n.t("assignment_create_success", scope: SCOPE)
    end
  end
end
