class AssignmentsController < ApplicationController
  SCOPE = "activerecord.errors.controllers.assignment".freeze # Necessary to acces locales file
  def new
    @offspring = Offspring.find_by_id(params[:format])
    @rooms = Room.all
  end

  def create
    if admin_allows_changes?
      Offspring.transaction do
      of = Offspring.lock.find_by_id(params["format"])
      of.shift = Shift.find_by_id(params["shift"])
      of.save
    end
    else
      flash[:alert] = I18n.t("admin_locked_create", scope: SCOPE)
    end
    redirect_to root_url
  end

  def destroy
    of = Offspring.find_by_id(params["id"])
    of.shift = nil
    of.save
    redirect_to new_assignment_path(of)
  end

  private

  def admin_allows_changes?
    !ApplicationHelper.status_lock?
  end
end
