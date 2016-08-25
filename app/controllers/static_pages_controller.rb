class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :help]
  def home
    unless signed_in?
      redirect_to new_user_session_path
      return
    end
    @user = current_user || current_admin
  end

  def about
  end

  def help
  end

  def admin
  end

  def instructions
  end
end
