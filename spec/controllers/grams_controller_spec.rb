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
        get :new
      end
  end
end
