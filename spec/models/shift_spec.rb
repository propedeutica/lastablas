require 'rails_helper'

RSpec.describe Shift, type: :model do
  let(:shift) { FactoryGirl.build(:shift) }
  it "has a valid model" do
    shift.valid?
    expect(shift).to be_valid
  end

  it "has a day of the week" do
    shift.day_of_week = nil
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:day_of_week]).to include "no puede estar vacío"
  end
  it "day is an integer greater or equal to 1" do
    shift.day_of_week = 0
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:day_of_week]).to include "tiene que ser mayor o igual a 1"
  end

  it "days is an integer lower or equal to 7" do
    shift.day_of_week = 8
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:day_of_week]).to include "tiene que ser menor o igual a 7"
  end

  it "prebooked is an integer" do
    shift.prebooked = "seven"
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:prebooked]).to include "tiene que ser un número entero"
  end

  it "prebooked is lower than the capacity of the room it belongs to" do
    shift.prebooked = shift.room.capacity + 1
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:shift]).to include "Sites available under 0"
  end

  it "start_time is a time" do
    expect(shift.start_time).to be_instance_of(String)
    shift.valid?
    expect(shift).to be_valid
  end

  it "end_time is a time" do
    expect(shift.end_time).to be_instance_of(String)
    shift.valid?
    expect(shift).to be_valid
  end

  it "start_time is not a wrong time" do
    expect do
      FactoryGirl.create(:shift, start_time: "24:00")
    end.to raise_exception("no es válido")
    shift.start_time = "24:00"
    shift.valid?
    expect(shift).not_to be_valid

    expect do
      FactoryGirl.create(:shift, start_time: "23:60")
    end.to raise_exception("no es válido")
    shift.start_time = "23:60"
    shift.valid?
    expect(shift).not_to be_valid
  end

  it "end_time is not a wrong time" do
    expect do
      FactoryGirl.create(:shift, end_time: "24:00")
    end.to raise_exception("no es válido")
    shift.end_time = "24:00"
    shift.valid?
    expect(shift).not_to be_valid

    expect do
      FactoryGirl.create(:shift, end_time: "23:60")
    end.to raise_exception("no es válido")
    shift.end_time = "23:60"
    shift.valid?
    expect(shift).not_to be_valid
  end

  it "start_time earlier than end_time is valid." do
    shift = FactoryGirl.create(:shift, start_time: "10:00", end_time: "10:30")
    shift.valid?
    expect(shift).to be_valid
  end

  it "start_time not earlier than end_time is invalid." do
    expect do
      FactoryGirl.create(:shift, start_time: "10:30", end_time: "10:00")
    end.to raise_exception("no es válido")
    shift.start_time = "10:30"
    shift.end_time = "10:00"
    shift.valid?
    expect(shift).not_to be_valid
  end

  pending "relations are nullified whtn the shift is detroyed"
  pending "it gives back the number of spaces available"
end
