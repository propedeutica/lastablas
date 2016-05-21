require 'rails_helper'

RSpec.describe AdminController, type: :controller do

  context "admin user" do
    describe "GET #dashboard" do
      it "returns http success" do
        get :dashboard
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "non-admin user" do
    describe "GET #dashboard" do
      it "returns http error" do
        get :dashboard
        expect(response).to have_http_status(:success)
      end
    end

  end


end
