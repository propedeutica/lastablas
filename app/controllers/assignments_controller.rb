class AssignmentsController < ApplicationController
  def new
    @offspring = Offspring.find_by_id(params[:format])
    @rooms = Room.all
  end

  def index

  end
end
