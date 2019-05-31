class AnimalsController < ApplicationController
  def index
    @animals = Animal.all
  end

  def show
    @animal = Animal.find(params[:id])
  end

  def new
  end

  def create
    @animal = Animal.new(animal_params)

    @animal.save
    redirect_to @animal
  end

  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy

    redirect_to animals_path
  end

  private
    def animal_params
      params.require(:animal).permit(:name)
    end
end
