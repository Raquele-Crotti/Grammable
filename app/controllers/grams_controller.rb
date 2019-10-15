class GramsController < ApplicationController
  def new
    @gram = Gram.new
  end

  def index
  end

  def create
    @gram = Gram.create(gram_params) #save the gram to our database
    redirect_to root_path
  end

  private

  def gram_params
    params.require(:gram).permit(:message) #pull submitted form data from the params
  end
end
