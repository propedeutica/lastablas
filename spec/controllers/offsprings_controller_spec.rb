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
      # pending "redirects to authentication" 
      # You are not supposed to test an operation performed by another controller in offspring. 
      # We suggest to do this test in static_pages_controller_spec.rb
    end
    context "When authenticated" do
      # pending "shows index of offspring" 
      # You are not supposed to test an operation performed by another controller in offspring. 
      # We suggest to do this test in static_pages_controller_spec.rb
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
      describe "and not in first grade" do
        it "does not allow any other" do
          sign_in user
          Offspring.grades.keys.each do |i|
            if i != 'primary_first'
              expect{
                post :create, offspring: {first_name: "pepe", last_name: "kata", :grade => i}
              }.to change(user.offsprings, :count).by(0)
            end
          end
        end
        

        it "redirects to /static_pages/intructions" do
          sign_in user
          Offspring.grades.keys.each do |i|
            if i != 'primary_first'
              post :create, offspring: {first_name: "pepe", last_name: "kata", :grade => i}
              expect(response).to redirect_to(static_pages_intructions_path)
            end    
          end  
        end 
      end
    end  
  end  
end