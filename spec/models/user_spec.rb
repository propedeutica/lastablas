require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { user=FactoryGirl.build(:user) }

  it "is valid with everything properly filled" do
    user.valid?
    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user.first_name="   "
    user.valid?
    expect(user.errors[:first_name]).to include "no puede estar vacío"
  end

  it "is invalid with a first name too short" do
    user.first_name="aa"
    user.valid?
    expect(user.errors[:first_name]).to include "demasiado corto"
  end

  it "is invalid with a first name too long" do
    user.first_name="a"*61
    user.valid?
    expect(user.errors[:first_name]).to include "demasiado largo"
  end

  it "is invalid without a last name" do
    user.last_name="    "
    user.valid?
    expect(user.errors[:last_name]).to include "no puede estar vacío"
  end
  it "is invalid with a last name too short" do
    user.last_name="a"
    user.valid?
    expect(user.errors[:last_name]).to include "demasiado corto"
  end

  it "is invalid with a last name too long" do
    user.last_name="a"*61
    user.valid?
    expect(user.errors[:last_name]).to include "demasiado largo"
  end

  it "is invalid without an email" do
    user.email="   "
    user.valid?
    expect(user.errors[:email]).to include "no puede estar vacío"
  end

  it "is invalid with a too short email" do
    user.email="a"
    user.valid?
    expect(user.errors[:email]).to include "demasiado corto"
  end

  it "is invalid with a too long email" do
    user.email="a"*255+"b"
    user.valid?
    expect(user.errors[:email]).to include "demasiado largo"
  end

  it "accepts valid emails" do
    valid_addresses= %w[user@example.com USER@foo.COM A_U-ER@foo.bar.org
                                        first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email= valid_address
      user.valid?
      expect(user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "rejects invalid emails" do
    invalid_addresses= %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user.email=invalid_address
      user.valid?
      expect(user).not_to be_valid, "#{invalid_address.inspect} should be invalid"
      expect(user.errors[:email]).to include "no es válido"
    end
  end

  it "rejects duplicate emails" do
    user2=FactoryGirl.build(:user)
    user2.email=user.email.upcase.dup
    user2.save
    user.valid?
    expect(user.errors[:email]).to include "ya existe"
  end

  it "is invalid without a phone" do
    user.phone="  "
    user.valid?
    expect(user.errors[:phone]).to include "no puede estar vacío"
  end

  it "is invalid with a phone too long" do
    user.phone="1"*14
    user.valid?
    expect(user.errors[:phone]).to include "demasiado largo"
  end

  it "is invalid with a phone too short" do
    user.phone="1"*8
    user.valid?
    expect(user.errors[:phone]).to include "demasiado corto"
  end

  it "rejects invalid phone numbers" do
    invalid_telephone_numbers =
                 %w["6001" "+346001" "0034600" "1234567890" "abc" "6oo123456"]
    invalid_telephone_numbers.each do |invalid_telephone_number|
      user.phone=invalid_telephone_number
      user.valid?
      expect(user).not_to be_valid,
                      "#{invalid_telephone_number.inspect} should be rejected"
      expect(user.errors[:phone]).to include "no es válido"
    end
  end
  it  "accepts valid phone numbers" do
    valid_telephone_numbers =
          %w[600123456 +34600123456 0034600123456 914270000 0034914270123]
    valid_telephone_numbers.each do |valid_telephone_number|
         user.phone=valid_telephone_number
         user.valid?
         expect(user).to be_valid,
                      "#{valid_telephone_number.inspect} should be valid"

    end
  end
  it "is invalid without a password" do
    user.password= "  "
    user.valid?
    expect(user.errors[:password]).to include "no puede estar vacío"
  end

  it "is invalid with a password too short" do
    user.password= "a"*7
    user.valid?
    expect(user.errors[:password]).to include "demasiado corto"
  end
  it "is invalid with a password too long" do
    user.password= "a"*73
    user.valid?
    expect(user.errors[:password]).to include "demasiado largo"
  end

  it "stores emails in lower case" do
    mixed_case_email="MixED@EMail.coM"
    user.email=mixed_case_email.dup
    user.save
    expect(user.email).not_to eq(mixed_case_email)
  end
end
