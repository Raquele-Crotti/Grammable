require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "comments#create action" do
    it "should allow users to create comments on grams" do
      gram = FactoryBot.create(:gram) #using FactoryBot to create a gram

      user = FactoryBot.create(:user)#using FactoryBot ro create a user
      sign_in user #user is signed in

      post :create, params: { gram_id: gram.id, comment: { message: 'awesome gram!' } } #trigger a gram to the create action and specify a message of awesome gram!
    
      expect(response).to redirect_to root_path #ensure user is redirected to correct place
      expect(gram.comments.length).to eq 1 #a single comment has been created in database
      expect(gram.comments.first.message).to eq "awesome gram!" #ensure that comment has message 'awesome gram!'
    end

    it "should require a user to be logged in to comment on a gram" do
      gram = FactoryBot.create(:gram) #create gram
      post :create, params: {gram_id: gram.id, comment: { message: 'awesome gram!' } } #Trigger an HTTP POST to the create action, with the message of "awesome gram!"
      expect(response).to redirect_to new_user_session_path #redirect to sign-in page
    end

    it "should return http status code of not found if the gram isn't found" do
      user = FactoryBot.create(:user)#create user
      sign_in user #sign in user
      post :create, params: { gram_id: 'YOLOSWAG', comment: { message: 'awesome gram' } } #trigger an HTTP POST request to the create action, with the gram_id populated as YOLOSWAG, with the form data of awesome gram in the message
      expect(response).to have_http_status :not_found #return HTTP repsonse of 404 Not Found
    end
  end
end
