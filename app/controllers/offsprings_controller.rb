# Offsprings are dependent on users and are the ones that get assigned to shifts
# They can't be assigned themselves, and need the process to be done by the user
class OffspringsController < ApplicationController
  SCOPE = "activerecord.errors.controllers.offspring".freeze
  def show
  end

  def index
  end

  def new
    @offspring = current_user.offsprings.build
  end

  def create
    if access_control?
      @offspring = current_user.offsprings.build(offsprings_params)
      unless @offspring.primary_first?
        flash[:warning] = "Sólo puede añadir a niños de 1º de Primaria"
        redirect_to static_pages_intructions_path
        return
      end
      save_offspring(@offspring)
    else
      flash[:alert] = I18n.t("admin_locked_create", scope: SCOPE)
    end
    redirect_to root_path
  end

  def destroy
    if access_control?
      offspring = Offspring.find_by_id(params[:id])
      offspring.destroy
      flash[:success] = "Niño borrado"
    else
      flash[:alert] = I18n.t("admin_locked_destroy", scope: SCOPE)
    end
    redirect_to request.referer || root_url
  end

  private

  def offsprings_params
    params.require(:offspring).permit(:first_name, :last_name, :grade)
  end

  def save_offspring(off)
    if off.save
      flash[:success] = "Niño añadido"
    else
      flash[:danger] = "No se pudo añadir al niño"
    end
  end

  def access_control?
    !ApplicationHelper.status_lock?
  end
end
