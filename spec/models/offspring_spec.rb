require 'rails_helper'

RSpec.describe Offspring, type: :model do
  let(:child) { FactoryGirl.build(:offspring) }
  it "has a valid factory" do
    expect(child).to be_valid
  end

  it "is invalid without a name" do
    child.first_name = nil
    expect(child).not_to be_valid
    child.valid?
    expect(child.errors[:first_name]).to include("no puede estar vacío")
  end

  it "is invalid without a surname" do
    child.last_name = nil
    expect(child).not_to be_valid
    child.valid?
    expect(child.errors[:last_name]).to include("no puede estar vacío")
  end

  it "should have the same surname than the brothers" do
    child.save
    brother = FactoryGirl.build(:offspring, user: child.user, last_name: "aaassssddd")
    brother.valid?
    expect(brother.errors[:last_name]).to include("tiene que coincidir con el de sus hermanos")
  end

  it "is invalid wihout an course" do
    child.grade = nil
    expect(child).not_to be_valid
    child.valid?
    expect(child.errors[:grade]).to include("no puede estar vacío")
  end

  it 'is in any grade' do
    Offspring.grades.keys.each do |i|
      child.grade = i
      expect(child).to be_valid
    end
  end

  it "is invalid without a user associated" do
    child.user = nil
    expect(child).not_to be_valid
  end

  it "is destroyed when the user associated is" do
    child = FactoryGirl.create(:offspring)
    expect { child.user.destroy! }.to change { Offspring.count }.by(-1)
  end
end
