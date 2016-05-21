class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about, :help]
  def home
    @user=current_user
  end

  def about
  end

  def help
  end

  def admin
  end

end
