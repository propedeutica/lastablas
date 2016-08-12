require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  context "invalid " do
    let(:offspring) { FactoryGirl.build(:offspring) }
    let(:shift) { FactoryGirl.build(:shift) }

    describe "Offspring," do
      it "should not allow an offspring without first name" do
        offspring.first_name = nil
        expect(offspring).not_to be_valid
        expect(offspring.errors[:first_name]).to include "no puede estar vacío"
      end

      it "should not allow an offspring without user" do
        offspring.user = nil
        expect(offspring).not_to be_valid
        expect(offspring.errors[:user]).to include "no puede faltar"
      end

      it "should not allow an offspring without last name" do
        offspring.last_name = nil
        expect(offspring).not_to be_valid
        expect(offspring.errors[:last_name]).to include "no puede estar vacío"
      end

      it "should not allow an offspring without grade" do
        offspring.grade = nil
        expect(offspring).not_to be_valid
        expect(offspring.errors[:grade]).to include "no puede estar vacío"
      end
    end

    describe "Shift," do
      it "should not allow a shift without day_of_week" do
        shift.day_of_week = nil
        shift.valid?
        expect(shift).not_to be_valid
        expect(shift.errors[:day_of_week]).to include "no puede estar vacío"
      end
      it "should not allow a shift without start_time" do
        shift.start_time = nil
        shift.valid?
        expect(shift).not_to be_valid
        expect(shift.errors[:start_time]).to include "no puede estar vacío"
      end
      it "should not allow a shift without end_time" do
        shift.end_time = nil
        shift.valid?
        expect(shift).not_to be_valid
        expect(shift.errors[:end_time]).to include "no puede estar vacío"
      end
      it "should not allow a shift without prebooked" do
        shift.prebooked = nil
        shift.valid?
        expect(shift).not_to be_valid
        expect(shift.errors[:prebooked]).to include "no puede estar vacío"
      end
    end
  end

  context "valid offspring and/or shift" do
    let(:offspring) { FactoryGirl.build(:offspring) }
    let(:shift) { FactoryGirl.build(:shift) }
    it "should not allow a shift to be assigned when there are no empty places" do
      shift.prebooked = shift.room.capacity
      offspring.shift = shift
      expect(offspring).not_to be_valid
    end
  end

  describe "GET #new" do
    let(:user) { FactoryGirl.create(:user) }
    it "returns http success" do
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
