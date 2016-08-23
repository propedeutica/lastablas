require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do
  context "When user logged in" do
  end
  context "When admin logged in" do
  end
  context "When NOT logged in" do
    it "#GET index" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "#GET new" do
      get :new
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#POST create" do
      expect do
        post :create, shift: {day_of_week: 1, start_time: "10:00", end_time: "11:00"}
      end.to change(Shift.all, :count).by(0)
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#GET show" do
      shift = FactoryGirl.build_stubbed(:shift)
      get :show, id: shift.id
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#GET edit" do
      shift = FactoryGirl.build_stubbed(:shift)
      get :edit, id: shift.id
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#PUT update" do
      shift = FactoryGirl.create(:shift)
      put :update, id: shift.id, shift: {day_of_week: 1, start_time: "10:00", end_time: "11:00"}
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "#DELETE destroy" do
      shift = FactoryGirl.build_stubbed(:shift)
      expect { delete :destroy, id: shift.id }.to change(Shift.all, :count).by(0)
      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
