# Primary user of the application
# Offsprings are dependent on them
# They are the ones that need to perform the process on behalf of the offspring
class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id]) || current_user
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  
end
