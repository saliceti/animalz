class FamiliesController < ApplicationController

  def index
    @families = Family.all
  end

  def new
  end

  def edit
    @family = Family.find(params[:id])
  end

  def show
   @family = Family.find(params[:id]) unless @family
  end

  def create
   @family = Family.new(family_params)

   @family.save
   redirect_to @family
  end

  def update
    @family = Family.find(params[:id])

    if @family.update(family_params)
      redirect_to @family
    else
      render 'edit'
    end
  end

  def destroy
    @family = Family.find(params[:id])
    if @family.destroy then
      redirect_to families_path
    else
      render 'show'
    end
  end

  private
   def family_params
     params.require(:family).permit(:name, :text)
   end

 end
