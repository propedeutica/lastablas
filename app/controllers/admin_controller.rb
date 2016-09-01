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
    @users_count = User.where(admin: false).count
    @offspring_count = Offspring.all.count
    @zero_offspring_count = User.count - User.joins(:offsprings).uniq.count
    @users_with_at_least_2_offspring = user_2_offspr_count
  end

  private

  def admin_user?
    unless current_user.admin?
      redirect_to home_path
    end
  end

  def user_2_offspr_count
    count = 0
    User.all.each do |u|
      count += 1 if u.more_than_2_offspring?
    end
    count
  end
end
