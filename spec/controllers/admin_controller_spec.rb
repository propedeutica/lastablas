require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:user_admin) { FactoryGirl.create(:user, :administrator) }
  context "admin user" do
    describe "GET #dashboard" do
      it "returns http success" do
        sign_in user_admin
        get :dashboard
        expect(response).to have_http_status(:success)
      end
    end
    describe "can block any change in the data" do
      before(:all)do
        expect(user_admin).to be_an_instance_of(Admin)
      end
      before(:each)do
        get :status_lock_in_changes
        if @status == true
          post :switch_lock_in_changes
        end
      end
      it "succesfully" do #starts in false switch lock
        post :switch_lock_in_changes
      end
      pending "and unblock changes" 
      pending ", users cas still delete their own account" 
    end
  end

  let(:user) { FactoryGirl.create(:user) }
  context "non-admin user" do
    describe "GET #dashboard" do
      it "returns http error" do
        sign_in user
        get :dashboard
        expect(response).to redirect_to(home_path)
      end
    end
  end
end
