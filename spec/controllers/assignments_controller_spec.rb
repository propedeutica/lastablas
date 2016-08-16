require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  context "invalid " do
    let(:offspring) { FactoryGirl.build_stubbed(:offspring) }
    let(:shift) { FactoryGirl.build_stubbed(:shift) }

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

  context "not authnticated" do
    let(:offspring) { FactoryGirl.build_stubbed(:offspring) }
    let(:shift) { FactoryGirl.build_stubbed(:shift) }

    it "GET #new fails" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
    it "POST #create fails" do
      post :create, format: offspring.id, shift: shift.id
      expect(response.response_code).to eq 401
    end
    it "DELETE #destroys fails" do
      post :destroy, id: offspring.id
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "valid offspring and/or shift" do
    let(:offspring) { FactoryGirl.build_stubbed(:offspring) }
    let(:shift) { FactoryGirl.build_stubbed(:shift) }

    it "should allow to assign to a valid shift" do
      shift.prebooked = 0
      offspring.shift = shift
      offspring.valid?
      expect(offspring).to be_valid
    end

    it "should not allow a shift to be assigned when there are no empty places" do
      shift.prebooked = shift.room.capacity
      offspring.shift = shift
      offspring.valid?
      expect(offspring).not_to be_valid
      expect(offspring.errors[:shift]).to include "no hay espacio"
    end

    describe "authnticated" do
      let(:user) { FactoryGirl.create(:user) } # Necessary creat to sign in
      let(:offspring) { FactoryGirl.create(:offspring) }
      let(:shift) { FactoryGirl.create(:shift) }
      before(:each) do
        sign_in user
      end

      it "GET #new returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "POST #create returns" do
        expect do
          post :create,  format: offspring.id, shift: shift.id
        end.to change(shift.offsprings, :count).by(1)
        expect(response).to redirect_to(root_path)
      end
      it "DELETE #destroy returns" do
        offspring.shift = shift
        offspring.save
        expect do
          delete :destroy, id: offspring.id
        end.to change(shift.offsprings, :count).by(-1)
        expect(response).to redirect_to(new_assignment_path + '.' + offspring.id.to_s)
      end
    end
  end
end
