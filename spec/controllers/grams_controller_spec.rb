require 'rails_helper'

RSpec.describe GramsController, type: :controller do

  describe "grams#update action" do
    it "should allow users to successfully update grams" do
      gram = FactoryBot.create(:gram, message: "Initial Value") #create a grma in the database with the message of "Initial Value"
      patch :update, params: { id: gram.id, gram: { message: 'Changed' } } #trigger an http patch request to the update action and use the form data to be 'Changed'
      expect(response).to redirect_to root_path
      gram.reload
      expect(gram.message).to eq "Changed" #after reloading gram from database, we check to see if the value of it's message is equal to 'Changed'
    end

    it "should have http 404 error if the gram cannot be found" do
      patch :update, params: { id: "YOLOSWAG", gram: {message: 'Changed' } } #if user submits an updated gram that cannot be found in our database
      expect(response).to have_http_status(:not_found) #render 404 Not Found response
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      gram = FactoryBot.create(:gram, message: "Initial Value") #we need to have a gram in our database when action happens
      patch :update, params: { id: gram.id, gram: { message: ''}} #perform http patch request but with empty string
      expect(response).to have_http_status(:unprocessable_entity) #expect status 422 Unprocessable Entity
      gram.reload
      expect(gram.message).to eq "Initial Value" #reload gram from database with latest value and expect it to now be equal to "initial Value"
    end
  end

  describe "grams#edit action" do
    it "should successfully show the edit form if the gram is found" do
      gram = FactoryBot.create(:gram)
      get :edit, params: { id: gram.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the gram is not found" do
      get :edit, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "grams#show action" do
    it "should successfully show the page if the gram is found" do
      gram = FactoryBot.create(:gram) #push a new gram to the database
      get :show, params: { id: gram.id } #trigger an HTTP request to /grams/:id where id is replaced by the gram jiust created
      expect(response).to have_http_status(:success) #expect successful HTTP status code
    end

    it "should return a 404 error if the gram is not found" do
      get :show, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)
    end
  end

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
