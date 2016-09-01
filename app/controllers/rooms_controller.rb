# Contoller for Rooms, where the user can see and assing shifts
class RoomsController < ApplicationController
  SCOPE = "activerecord.errors.controllers.room".freeze # Necessary to acces locales file

  def index
    @rooms = Room.all
  end

  def new
    if admin_user?
      @room = Room.new
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to home_path
    end
  end

  def create
    @room = Room.new(room_params)
    if admin_user?
      create_room @room
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to home_path
    end
  end

  def show
    @room = Room.find_by_id(params[:id])
    if admin_user?
      if @room.nil?
        flash[:danger] = I18n.t("show_wrong", scope: SCOPE)
        redirect_to home_path
      end
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to home_path
    end
  end

  def edit
    @room = Room.find_by_id(params[:id])
    edit_room @room
  end

  def update
    @room = Room.find_by_id(params["id"])
    update_room @room
  end

  def destroy
    if admin_user?
      room = Room.find_by_id(params[:id])
      destroy_room room
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to home_path
    end
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

  def create_room(roo)
    if roo.save
      flash[:success] = I18n.t("create_correct", scope: SCOPE)
      render 'new'
    else
      flash[:danger] = I18n.t("create_wrong", scope: SCOPE)
      redirect_to request.referer || new_room_path
    end
  end

  def edit_room(roo)
    if admin_user?
      if roo.nil?
        flash[:danger] = I18n.t("edit_wrong", scope: SCOPE)
        redirect_to request.referer || home_path
        return
      end
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to home_path
    end
  end

  def update_room(roo)
    if admin_user?
      if roo.nil?
        flash[:danger] = I18n.t("room_non-existing", scope: SCOPE)
        redirect_to request.referer || rooms_path
      else
        update_room_attributes(@room)
      end
    else
      flash[:warning] = I18n.t("not_admin", scope: SCOPE)
      redirect_to home_path
    end
  end

  def destroy_room(roo)
    if roo.nil?
      flash[:danger] = I18n.t("room_non-existing", scope: SCOPE)
    elsif roo.destroy
      flash[:success] = I18n.t("room_destroy_correct", scope: SCOPE)
    else
      flash[:danger] = I18n.t("room_destroy_wrong", scope: SCOPE)
    end
    redirect_to rooms_url
  end

  def room_params
    params.require(:room).permit(:name, :capacity)
  end

  def access_control?
    ApplicationHelper.status_lock?
  end

  def admin_user?
    current_user.admin?
  end
end
