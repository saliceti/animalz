class AnimalsController < ApplicationController
  def index
    @animals = Animal.all
  end

  def show
    @animal = Animal.find(params[:id])
    @family = Family.find(@animal.family_id)
  end

  def new
    if params[:family_id] then
      @family = Family.find(params[:family_id])
    else
      @families = Family.all
    end
  end

  def edit
    @animal = Animal.find(params[:id])
  end

  def create
    @animal = Animal.new(animal_params)

    @animal.save
    redirect_to @animal
  end

  def update
    @animal = Animal.find(params[:id])

    if @animal.update(animal_params)
      redirect_to @animal
    else
      render 'edit'
    end
  end

  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy

    redirect_to animals_path
  end

  private
    def animal_params
      params.require(:animal).permit(:name, :family_id)
    end
end
