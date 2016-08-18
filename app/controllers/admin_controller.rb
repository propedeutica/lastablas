# Admin users can see and act upon all the informatoin in the database
# and not only in their information
# They have an speicific layout to reflec this
class AdminController < ApplicationController
  layout 'admin'
  before_action :admin_user?

  def dashboard
    @users = User.paginate(page: params[:users_page])
    @offsprings = Offspring.paginate(page: params[:offsprings_page])
    @rooms = Room.all
    @users_count = User.where(admin: false).count
    
  end

  def offsprings
    @offsprings = Offspring.paginate(page: params[:offsprings_page])
  end

  def rooms
    @rooms = Room.all
  end



  private

  def admin_user?
    unless current_user.admin?
      redirect_to home_path
    end
  end
end
