# Admin users can see and act upon all the informatoin in the database
# and not only in their information
# They have an speicific layout to reflec this
class AdminController < ApplicationController
  layout 'admin'
  before_action :admin_user?

  def dashboard
    @users = User.all
    @offsprings = Offspring.all
    @rooms = Room.all
  end

  def offsprings
    @offsprings = Offspring.all
  end

  def rooms
    @rooms = Room.all
  end

  def status_lock_in_changes

  end
  
  def switch_lock_in_changes

  end

  private

  def admin_user?
    unless current_user.admin?
      redirect_to home_path
    end
  end
end
