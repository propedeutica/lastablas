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

  it "is invalid wihout an age" do
    child=FactoryGirl.build(:offspring, age:nil)
    expect(child).not_to be_valid
    child.valid?
    expect(child.errors[:age]).to include("no puede estar vacío")
  end

  it "has an age higher than or equal to 10 " do
    child=FactoryGirl.build(:offspring, age:9)
    expect(child).not_to be_valid
    expect(child.errors[:age]).to include("tiene que ser mayor o igual a 10")
  end

  it "has an age less than or equal to 18 " do
    child=FactoryGirl.build(:offspring, age:19)
    expect(child).not_to be_valid
    expect(child.errors[:age]).to include("tiene que ser menor o igual a 18")
  end

  it "has an age that is an integer" do
    child=FactoryGirl.build(:offspring, age:7.2)
    expect(child).not_to be_valid
    expect(child.errors[:age]).to include("tiene que ser entero")

  end

  it "is invalid without a user associated" do
    child=FactoryGirl.build(:offspring, user:nil)
    expect(child).not_to be_valid
  end

  it "is destroyed when the user associated is" do
    child=FactoryGirl.create(:offspring)
    expect { child.user.destroy! }.to change{ Offspring.count}.by(-1)
  end
end
