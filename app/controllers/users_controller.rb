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

  def destroy
    user = User.find_by_id(params[:id])
    debugger
    if delete_possible?(user)
      user.destroy
      flash[:warning] = "Usuario #{user.email} borrado"
      # You can access the variable even if the database has been changed
      redirect_to root_url
    else
      redirect_to home_path
    end
  end

  private

  def delete_possible?(user)
    if user.nil?
      return false
    elsif user == current_user
      return false
    elsif !current_user.admin?
      return false
    else
      return true
    end
  end
end
