# Offsprings are dependent on users and are the ones that get assigned to shifts
# They can't be assigned themselves, and need the process to be done by the user
class OffspringsController < ApplicationController
  def show
    @offsprings = Offspring.paginate(page: params[:offsprings_page])
  end

  def new
    @offspring = current_user.offsprings.build
  end

  def create
    @offspring = current_user.offsprings.build(offsprings_params)
    if !@offspring.primary_first?
      flash[:warning] = "No se puedo añadir al niño"
      redirect_to static_pages_intructions_path
      return
    elsif @offspring.save
      flash[:success] = "Niño añadido"
    else
      flash[:danger] = "No se pudo añadir al niño"
    end
    redirect_to root_path
  end

  def destroy
    offspring = Offspring.find_by_id(params[:id])
    offspring.destroy
    flash[:success] = "Niño borrado"
    redirect_to request.referer || root_url
  end

  private

  def offsprings_params
    params.require(:offspring).permit(:first_name, :last_name, :grade)
  end
end
