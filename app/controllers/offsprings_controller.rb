# Offsprings are dependent on users and are the ones that get assigned to shifts
# They can't be assigned themselves, and need the process to be done by the user
class OffspringsController < ApplicationController
  SCOPE = "activerecord.errors.controllers.offsprings".freeze
  def show
  end

  def new
    @offspring = current_user.offsprings.build
  end

  def create
    access_control? ? create_offspring : flash[:warning] = I18n.t("admin_locked_create", scope: SCOPE)
    redirect_to root_path
  end

  def destroy
    access_control? ? destroy_offspring : flash[:warning] = I18n.t("admin_locked_destroy", scope: SCOPE)
    redirect_to request.referer || root_path
  end

  private

  def offsprings_params
    params.require(:offspring).permit(:first_name, :last_name, :grade)
  end

  def access_control?
    !ApplicationHelper.status_lock?
  end

  def create_offspring
    @offspring = current_user.offsprings.build(offsprings_params)
    if !@offspring.primary_first?
      flash[:warning] = "Sólo puede añadir a niños de 1º de Primaria"
      redirect_to static_pages_intructions_path
      return
    elsif @offspring.save
      flash[:success] = "Niño añadido"
    else
      flash[:danger] = "No se pudo añadir al niño"
    end
  end

  def destroy_offspring
    offspring = Offspring.find_by_id(params[:id])
    if offspring.destroy
      flash[:success] = I18n.t("destroy_correct", scope: SCOPE)
    else
      flash[:warning] = I18n.t("destroy_wrong", scope: SCOPE)
    end
  end
end
