require 'rails_helper'
include Devise::TestHelpers # this should work without this

RSpec.describe OffspringsController, type: :controller do
  describe "get INDEX" do
    before :all do
      3.times do
        FactoryGirl.create(:offspring)
      end
    end


    context "When not authenticated" do
      pending "redirects to authentication" do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        get :index, {}
        expect(assigns).to eq(nil) #it does not go through the controller
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context "When authenticated" do
      pending "shows index of offspring" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "get CREATE" do
    let(:user) {FactoryGirl.create(:user)}

    context "When create new offspring" do
      it "allows primary_first children" do
        sign_in user 
        expect{
          post :create, offspring: {first_name: "pepe", last_name: "kata", grade: :primary_first}
        }.to change(user.offsprings, :count).by(1)
          
      end

      it "does not allow any other grade than first" do
        sign_in user 
        expect{
          post :create, offspring: {first_name: "pepe", last_name: "kata", grade: :primary_second}
        }.to change(user.offsprings, :count).by(0)
        expect{
          post :create, offspring: {first_name: "pepe", last_name: "kata", grade: :primary_third}
        }.to change(user.offsprings, :count).by(0)
        expect{
          post :create, offspring: {first_name: "pepe", last_name: "kata", grade: :others}
        }.to change(user.offsprings, :count).by(0)
          
      end
    end  
  end  
end
