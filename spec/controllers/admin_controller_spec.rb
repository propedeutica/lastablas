require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:user_admin) { FactoryGirl.create(:admin) }
  context "admin user" do
    describe "GET #dashboard" do
      it "returns http success" do
        sign_in user_admin
        get :dashboard
        expect(response).to have_http_status(:success)
      end
    end
    describe "POST #switch_lock_admin" do
      before(:each) do # we want to make sure we are starting in switch lock with false value
        sign_in user_admin
        post :switch_lock_admin if ApplicationHelper.status_lock?
      end
      xit "locks and unlocks changes succesfully" do
        post :switch_lock_admin
        expect(ApplicationHelper.status_lock?).to be true
        post :switch_lock_admin
        expect(ApplicationHelper.status_lock?).to be false
      end
      describe ",when enabled," do
        before(:each) do
          post :switch_lock_admin unless ApplicationHelper.status_lock?
        end
        before(:all) do
          user = FactoryGirl.build(:user)
          user.save
        end

        xit "users cannot #CREATE offspring" do
          ref = @controller # Storing pointer to current controller
          @controller = OffspringsController.new # Setting User controller to call
          sign_in user # Start user session
          expect do
            post :create, offspring: {first_name: "pepe", last_name: "kata", grade: :primary_first}
          end.to change(user.offsprings, :count).by(0)
          expect(response).to redirect_to(root_path)
          @controller = ref # Restoring previous admin controller
        end

        xit "users cannot #DESTROY offspring" do
          off = FactoryGirl.build(:offspring, user: user)
          off.save
          ref = @controller # Storing pointer to current controller
          @controller = OffspringsController.new # Setting User controller to call
          sign_in user # Start user session
          expect do
            delete :destroy, id: off.id
          end.to change(user.offsprings, :count).by(0)
          expect(response).to redirect_to(root_path)
          @controller = ref # Restoring previous admin controller
        end

        xit "users cannot assign offspring" do
          off = FactoryGirl.build(:offspring, user: user)
          off.save
          shi = FactoryGirl.build(:shift)
          shi.save
          ref = @controller # Storing pointer to current controller
          @controller = AssignmentsController.new # Setting User controller to call
          sign_in user # Start user session
          expect do
            post :create, format: off.id, shift: shi.id
          end.to change(shi.offsprings, :count).by(0)
          expect(response).to redirect_to(root_path)
          @controller = ref # Restoring previous admin controller
        end

        xit "it still allows users to delete their own account" do
          expect(ApplicationHelper.status_lock?).to be true
          ref = @controller # Storing pointer to current controller
          @controller = UsersController.new # Setting User controller to call
          sign_in user # Start user session
          expect do
            delete :destroy, id: user.id
          end.to change { User.count }.by(-1)
          @controller = ref # Restoring previous admin controller
        end

        after(:all) do
          # ApplicationHelper.switch_lock if ApplicationHelper.status_lock?
        end
      end
    end
  end

  let(:user) { FactoryGirl.create(:user) }
  context "non-admin user" do
    describe "GET #dashboard" do
      pending "returns http error"
    end
  end
end
