# Admin users can see and act upon all the informatoin in the database
# and not only in their information
# They have an speicific layout to reflec this
class AdminController < ApplicationController
  layout 'admin'
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!

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
