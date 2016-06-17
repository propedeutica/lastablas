require 'rails_helper'

RSpec.describe Offspring, type: :model do
  it "has a valid factory" do
    child = FactoryGirl.build(:offspring)
    expect(child).to be_valid
  end

  it "is invalid without a name" do
    child = FactoryGirl.build(:offspring, first_name:nil)
    expect(child).not_to be_valid
    child.valid?
    expect(child.errors[:first_name]).to include("no puede estar vacío")

  end

  it "is invalid without a surname" do
    child = FactoryGirl.build(:offspring, last_name:nil)
    expect(child).not_to be_valid
    child.valid?
    expect(child.errors[:last_name]).to include("no puede estar vacío")
  end

  it "is invalid wihout an course" do
    child=FactoryGirl.build(:offspring, grade:nil)
    expect(child).not_to be_valid
    child.valid?
    expect(child.errors[:grade]).to include("no puede estar vacío")
  end

  it 'is in any grade' do 
    Offspring.grades.keys.each do |i|
      child=FactoryGirl.build(:offspring, :grade => i)
      expect(child).to be_valid
    end 
  end 

  it "is invalid without a user associated" do
    child = FactoryGirl.build(:offspring, user:nil)
    expect(child).not_to be_valid
  end

  it "is destroyed when the user associated is" do
    child = FactoryGirl.create(:offspring)
    expect { child.user.destroy! }.to change{ Offspring.count}.by(-1)
  end
end
