require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  context "invalid offspring and/or shift" do
    pending
  end

  context "valid offspring and/or shift" do
    let(:offspring) { FactoryGirl.build(:offspring)}
    let(:shift) { FactoryGirl.build(:shift)}

    it "should not allow a shift to be assigned when ther are no empty places" do
      shift.prebooked=shift.room.capacity
      offspring.shift=shift
      expect(offspring).not_to be_valid
    end

  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end


end
