# Offsprings are dependent on users and are the ones that get assigned to shifts
# They can't be assigned themselves, and need the process to be done by the user
class OffspringsController < ApplicationController
  def show
  end

  def new
    @offspring = current_user.offsprings.build
  end

  def create
    @offspring = current_user.offsprings.build(offsprings_params)
    unless @offspring.primary_first?
      redirect_to static_pages_intructions_path
      return
    end
    if @offspring.save
      flash[:success] = "Niño añadido"
      redirect_to root_url
    else
      flash[:alert] = "No se pudo añadir al niño"
      redirect_to home_path
    end
  end

  def destroy
    offspring = Offspring.find_by_id(params[:id])
    offspring.destroy
    flash[:warning] = "Niño borrado"
    redirect_to request.referer || root_url
  end

  private

  def offsprings_params
    params.require(:offspring).permit(:first_name, :last_name, :grade)
  end
end
