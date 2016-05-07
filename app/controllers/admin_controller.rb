class AdminController < ApplicationController
  layout 'admin'

  def dashboard
    @users = User.paginate(page: params[:users_page])
    @offsprings = Offspring.paginate(page: params[:offsprings_page])
    @rooms = Room.all
  end

  def offsprings
    @offsprings = Offspring.paginate(page: params[:page])
  end

  def rooms
    @rooms = Room.all
  end
end
