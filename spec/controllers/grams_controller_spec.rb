require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    it "should successfully show the page" do  #specify what this test should do
      get :index  #trigger an HTTP get request
      expect(response).to have_http_status(:success) #we expect the response to have an HTTP status code that's successful
    end
  end

  describe "grams#new action" do
      it "should successfully show the new form" do
        get :new #trigger an HTTP GET request to the new action 
        expect(response).to have_http_status(:success) #we expect the response to have an HTTP status code that's successful
      end
  end

  describe "grams#create action" do
    it "should successfully create a new gram in our database" do
      post :create, params: { gram: {message: 'Hello!' } } #HTTP post request to the create action-user needs to fill out form with 'Hello!'
      expect(response).to redirect_to root_path #Expect the response to redirect to root path
    
      gram = Gram.last #load the last gram created in our database
      expect(gram.message).to eq("Hello!") #verifies the gram equals "Hello!"
    end
  end

end
