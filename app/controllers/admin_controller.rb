# Admin users can see and act upon all the informatoin in the database
# and not only in their information
# They have an speicific layout to reflec this
class AdminController < ApplicationController
  layout 'admin'
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!

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

  def switch_lock_admin
    ApplicationHelper.switch_lock
    render nothing: true
  end
end
