require 'rails_helper'
# include Devise::TestHelpers # this should work without this

RSpec.describe OffspringsController, type: :controller do
  context "When not authenticated," do
    it "does not allow to create" do
      post :create, offspring: {first_name: "pepe", last_name: "kata", grade: :primary_first}
      expect(response).to redirect_to('home')
    end

    it "does not allow access new" do
      get :new, {}
      expect(response).to redirect_to('home')
    end

    let(:user) { FactoryGirl.create(:user) }
    let(:off) { FactoryGirl.create(:offspring, user: user) }
    it "does not allow to destroy" do
      user.save
      off.save
      expect do
        delete :destroy, id: off.id
      end.to change(user.offsprings, :count).by(0)
      expect(response).to redirect_to('home')
    end

    pending "does not allow to see the index of offsprings"
    pending "visitor can't see offpsring@show"
    pending "visitor can't see other users"
  end

  context "When authenticated," do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
    end

    describe "#create" do
      it "allows creation of primary_first children" do
        expect do
          post :create, offspring: {first_name: "pepe", last_name: "kata", grade: :primary_first}
        end.to change(user.offsprings, :count).by(1)
        expect(response).to redirect_to(root_path)
      end
      it "does not allow any other and redirects" do
        Offspring.grades.keys.each do |i|
          next unless i != 'primary_first'
          expect do
            post :create, offspring: {first_name: "pepe", last_name: "kata", grade: i}
          end.to change(user.offsprings, :count).by(0)
          expect(response).to redirect_to(static_pages_intructions_path)
        end
      end
    end
    it "#new shows view for new offspring" do
      get :new, {}
      expect(response).to render_template(:new)
    end
    describe "#destroy" do
      let(:off) { FactoryGirl.create(:offspring, user: user) }
      it "allows destroying offspring" do
        off.save
        expect do
          delete :destroy, id: off.id
        end.to change(user.offsprings, :count).by(-1)
        expect(response).to redirect_to(root_url)
      end
      pending "does not allow destroying others' offsprings"
    end
    pending "#show show its data"
  end

  context "When admin authenticated" do
    # context should include specs based on its actions (create, new, show, etc)
    pending "can see offspring data"
    pending "can delete any offspring"
    pending "can create offpsring to any user"
  end
end
