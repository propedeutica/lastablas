require 'rails_helper'

RSpec.describe Shift, type: :model do
  let (:shift) { shift=FactoryGirl.build(:shift) }
  it "has a valid model" do
    shift.valid?
    expect(shift).to be_valid
  end

  it "has a day of the week" do
    shift.day_of_week=nil
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:day_of_week]).to include "no puede estar vacío"
  end
  it "day is an integer greater or equal to 1" do
    shift.day_of_week=0
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:day_of_week]).to include "tiene que ser mayor o igual a 1"
  end

  it "days is an integer lower or equal to 7" do
    shift.day_of_week=8
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:day_of_week]).to include "tiene que ser menor o igual a 7"
  end

  it "start_time is a time" do
    shift.start_time="lunes"
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:start_time]).to include "no puede estar vacío"
  end

  it "end_time is a time" do
    shift.end_time="lunes"
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:end_time]).to include "no puede estar vacío"
  end

  it "prebooked is an integer" do
    shift.prebooked="seven"
    shift.valid?
    expect(shift).not_to be_valid
    expect(shift.errors[:prebooked]).to include "tiene que ser un número entero"
  end

  pending "prebooked is lower than the capacity of the room it belongs to"
  pending "relations are nullified whtn the shift is detroyed"
  pending "it gives back the number of spaces available"
  pending "start_time is defined as HH:MM"
  pending "start_time is between 00:00 and 23:59"
  pending "end_time is defined as HH:MM"
  pending "start_time is earlier than end_time"
  pending "end_time is between 00:00 and 23:59"
end
