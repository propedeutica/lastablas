require 'rails_helper'
include Devise::TestHelpers # this should work without this

RSpec.describe UsersController, type: :controller do

  describe "GET #show" do
    let(:user) {FactoryGirl.create(:user)}
    it "returns http success" do
      sign_in user
      get :show, id:user.id
      expect(response).to have_http_status(:success)
    end
    pending "it shows the user data"
    pending "it shows the offspring"
  end

  describe "GET #index" do
    let(:user) {FactoryGirl.create(:user)}
    before(:all) {
      FactoryGirl.create(:offspring)
      FactoryGirl.create(:offspring)
    }
    it "returns http success" do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
    pending "it returns the list of users"
  end

end
