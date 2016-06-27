require 'rails_helper'

RSpec.describe Offspring, type: :model do
  it "has a valid factory" do
    child=FactoryGirl.build(:offspring)
    expect(child).to be_valid
  end

  it "is invalid without a name" do
    child=FactoryGirl.build(:offspring, first_name:nil)
    expect(child).not_to be_valid
    child.valid?
    expect(child.errors[:first_name]).to include("no puede estar vacío")

  end

  it "is invalid without a surname" do
    child=FactoryGirl.build(:offspring, last_name:nil)
    expect(child).not_to be_valid
    child.valid?
    expect(child.errors[:last_name]).to include("no puede estar vacío")
  end

  it "should have the same surname than the brothers" do
    child=FactoryGirl.create(:offspring)
    brother=FactoryGirl.build(:offspring, user: child.user, last_name:"aaassssddd")
    brother.valid?
    expect(brother.errors[:last_name]).to include("tiene que coincidir con el de sus hermanos")
  end

  it "is invalid wihout a grade" do
    child=FactoryGirl.build(:offspring, grade:nil)
    expect(child).not_to be_valid
    child.valid?
    expect(child.errors[:grade]).to include("no puede estar vacío")
  end

  #it "has a grade higher than or equal to 1 " do
  #  child=FactoryGirl.build(:offspring, grade:0)
  #  expect(child).not_to be_valid
  #  expect(child.errors[:grade]).to include("tiene que ser un curso válido")
  #end

  #it "has a grade less than or equal to 3 " do
  #  child=FactoryGirl.build(:offspring, grade:4)
  #  expect(child).not_to be_valid
  #  expect(child.errors[:grade]).to include("tiene que ser menor o válido")
  #end

  #it "has a grade that is an integer" do
  #  child=FactoryGirl.build(:offspring, grade:7.2)
  #  expect(child).not_to be_valid
  #  expect(child.errors[:grade]).to include("tiene que ser entero")
  #end

  pending "grades should belong to the grade list"

  it "is invalid without a user associated" do
    child=FactoryGirl.build(:offspring, user:nil)
    expect(child).not_to be_valid
  end

  it "is destroyed when the user associated is" do
    child=FactoryGirl.create(:offspring)
    expect { child.user.destroy! }.to change{ Offspring.count}.by(-1)
  end
end
