require 'rails_helper'

RSpec.describe Room, type: :model do
  let (:room) { room = FactoryGirl.build(:room) }
  it "has a valid constructor" do
    expect(room).to be_valid
  end

  it "is not valid without a name" do
    room.name = ""
    expect(room).not_to be_valid
    expect(room.errors[:name]).to include "no puede estar vacío"
  end

  it "has an integer capacity" do
    # active model does not record it in the database, appears as 0
  end
  it "has a positive capacity" do
    room.capacity = 0
    expect(room).not_to be_valid
    expect(room.errors[:capacity]).to include "debe ser positivo"
    room.capacity = -1
    expect(room).not_to be_valid
    expect(room.errors[:capacity]).to include "debe ser positivo"

  end
end
