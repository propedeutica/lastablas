require 'rails_helper'
include Devise::TestHelpers # this should work without this

RSpec.describe OffspringsController, type: :controller do
  context "When not authenticated," do
    it "does not allow to create" do
      expect {
        post :create, offspring: {first_name: "pepe", last_name: "kata", grade: :primary_first}
      }.to raise_error(NoMethodError, "undefined method `authenticate!' for nil:NilClass")
    end

    it "does not allow access new" do
      expect{
        get :new, {}
      }.to raise_error(NoMethodError, "undefined method `authenticate!' for nil:NilClass")
    end

    let(:user) { FactoryGirl.create(:user) }
    let(:off) { FactoryGirl.create(:offspring) }
    it "does not allow to destroy" do
      user.offsprings << off
      expect {
        delete :destroy, id: off.id
      }.to raise_error(NoMethodError, "undefined method `authenticate!' for nil:NilClass")
    end
  end

  context "When authenticated," do
    let(:user) { FactoryGirl.create(:user) }
    describe "#create" do
      it "allows creation of primary_first children" do
        sign_in user
        expect {
          post :create, offspring: {first_name: "pepe", last_name: "kata", grade: :primary_first}
        }.to change(user.offsprings, :count).by(1)
      end
      it "does not allow any other and redirects" do
        sign_in user
        Offspring.grades.keys.each do |i|
          if i != 'primary_first'
            expect{
              post :create, offspring: {first_name: "pepe", last_name: "kata", grade: i}
            }.to change(user.offsprings, :count).by(0)
            expect(response).to redirect_to(static_pages_intructions_path)
          end
        end
      end
      pending "#new shows view and fields for new offspring"
      describe "#destroy" do # We don't know the real functionality, we'll see how it works and adapt the test to it
        pending "allows destroying your offsprings"
        pending "does not allow destroyinh other's offsrpings"
      end
    end
  end
end
