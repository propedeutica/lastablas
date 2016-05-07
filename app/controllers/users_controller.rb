class UsersController < ApplicationController
  def show
    @user=User.find_by_id(params[:id])
    @user=@user||current_user   #### Have a look at this and see if you should change it
  end

  def index
    @users=User.paginate(page: params[:page])
  end
end
