class OffspringsController < ApplicationController
    before_action :authenticate_user!

 # def index
 #  @offsprings=Offspring.paginate(page: params[:page])
 # end

  def show
  end

  def new
    @offspring = current_user.offsprings.build
  end

  def create
    @offspring = current_user.offsprings.build(offsprings_params)
    if @offspring.save
      flash[:success]="Niño añadido"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    offspring=Offspring.find_by_id(params[:id])
    offspring.destroy
    flash[:warning] = "Niño borrado"
    redirect_to request.referrer || root_url
  end

  private
    def offsprings_params
      params.require(:offspring).permit(:first_name, :last_name, :age)
    end


end
