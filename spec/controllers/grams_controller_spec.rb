require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    it "should successfully show the page" do  #specify what this test should do
      get :index  #trigger an HTTP get request
      expect(response).to have_http_status(:success) #we expect the response to have an HTTP status code that's successful
    end
  end

  describe "grams#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
      
    it "should successfully show the new form" do
      user = FactoryBot.create(:user)
      sign_in user

      get :new #trigger an HTTP GET request to the new action 
      expect(response).to have_http_status(:success) #we expect the response to have an HTTP status code that's successful
    end
  end

  describe "grams#create action" do
    it "should require users to be logged in" do
      post :create, params: { gram: { message: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new gram in our database" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { gram: {message: 'Hello!' } } #HTTP post request to the create action-user needs to fill out form with 'Hello!'
      expect(response).to redirect_to root_path #Expect the response to redirect to root path
    
      gram = Gram.last #load the last gram created in our database
      expect(gram.message).to eq("Hello!") #verifies the gram equals "Hello!"
      expect(gram.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { gram: { message: '' } } #trigger an HTTP request to our create action and leave empty string as the message in the form it submits
      expect(response).to have_http_status(:unprocessable_entity) #expect reponse to have http status code of unprocessable entity
      expect(Gram.count).to eq Gram.count 
    end
  end

end
