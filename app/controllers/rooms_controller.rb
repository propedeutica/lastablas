# Contoller for Rooms, where the user can see and assing shifts
class RoomsController < ApplicationController
  SCOPE = "activerecord.errors.controllers.room".freeze # Necessary to acces locales file
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!, except: [:index]

  def index
    if user_signed_in? || admin_signed_in? # authenticate user or admin
      @rooms = Room.all
    else
      redirect_to new_user_session_path
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:success] = I18n.t("create_correct", scope: SCOPE)
      render 'new'
    else
      flash[:danger] = I18n.t("create_wrong", scope: SCOPE)
      redirect_to request.referer || new_room_path
    end
  end

  def show
    @room = Room.find_by_id(params[:id])
    if @room.nil?
      flash[:danger] = I18n.t("show_wrong", scope: SCOPE)
      redirect_to home_path
    end
  end

  def edit
    @room = Room.find_by_id(params[:id])
    if @room.nil?
      flash[:danger] = I18n.t("edit_wrong", scope: SCOPE)
      redirect_to request.referer || home_path
      return
    end
  end

  def update
    @room = Room.find_by_id(params["id"])
    if @room.nil?
      flash[:danger] = I18n.t("room_non-existing", scope: SCOPE)
      redirect_to request.referer || rooms_path
    else
      update_room_attributes(@room)
    end
  end

  def destroy
    room = Room.find_by_id(params[:id])
    if room.nil?
      flash[:danger] = I18n.t("room_non-existing", scope: SCOPE)
    elsif room.destroy
      flash[:success] = I18n.t("room_destroy_correct", scope: SCOPE)
    else
      flash[:danger] = I18n.t("room_destroy_wrong", scope: SCOPE)
    end
    redirect_to rooms_url
  end

  private

  def update_room_attributes(r)
    if r.update_attributes(room_params)
      flash[:success] = I18n.t("update_correct", scope: SCOPE)
      render 'edit'
      return
    end
    flash[:danger] = I18n.t("update_wrong", scope: SCOPE)
    redirect_to request.referer || rooms_path
  end

  def room_params
    params.require(:room).permit(:name, :capacity)
  end
end
