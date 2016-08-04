require 'rails_helper'

RSpec.describe Offspring, type: :model do
  let(:child) { FactoryGirl.build(:offspring) }

  it "has a valid factory" do
    child.valid?
    expect(child).to be_valid
  end

  it "is invalid without a name" do
    child.first_name = nil
    child.valid?
    expect(child.errors[:first_name]).to include("no puede estar vacío")
  end

  it "is invalid without a surname" do
    child.last_name = nil
    child.valid?
    expect(child.errors[:last_name]).to include("no puede estar vacío")
  end

  it "should have the same surname than the brothers" do
    child.save
    brother = FactoryGirl.build(:offspring, user: child.user, last_name: "aaassssddd")
    brother.valid?
    expect(brother.errors[:last_name]).to include("tiene que coincidir con el de sus hermanos")
  end

  it "is invalid wihout a grade" do
    child.grade = nil
    child.valid?
    expect(child.errors[:grade]).to include("no puede estar vacío")
  end

  it "is invalid with grades that don't belong to the grade list" do
    expect { child.grade = 100 }.to raise_error(ArgumentError).with_message(/is not a valid grade/)
  end

  it "is invalid without a user associated" do
    child.user = nil
    child.valid?
    expect(child.errors[:user]).to include("no puede faltar")
  end

  it "is destroyed when the user associated is" do
    child = FactoryGirl.create(:offspring)
    expect { child.user.destroy! }.to change { Offspring.count }.by(-1)
  end
end
