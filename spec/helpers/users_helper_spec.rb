require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UserHelper. For example:
#
# describe UserHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  let(:user) {FactoryGirl.create(:user, first_name:"First", last_name:"Last")}
  it "creates a joint user name" do
    expect(full_name_for(user)).to eq("First Last")
  end
end
