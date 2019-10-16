class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def new
    @gram = Gram.new
  end

  def index
  end

  def create
    @gram = current_user.grams.create(gram_params) #save the gram to our database
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def gram_params
    params.require(:gram).permit(:message) #pull submitted form data from the params
  end
end
