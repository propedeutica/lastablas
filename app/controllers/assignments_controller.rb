class AssignmentsController < ApplicationController
  def new
    @offspring = Offspring.find_by_id(params[:format])
    @rooms = Room.all
  end

  def create
    Offspring.transaction do
      of = Offspring.lock.find_by_id(params["format"])
      of.shift = Shift.find_by_id(params["shift"])
      of.save
      redirect_to root_url
    end
  end

  def destroy
    of = Offspring.find_by_id(params["id"])
    of.shift = nil
    of.save
    redirect_to new_assignment_path(of)
  end
end
