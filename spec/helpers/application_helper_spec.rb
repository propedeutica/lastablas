require 'rails_helper'
# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  it "returns base_title with no page_title is given" do
    expect(helper.full_title).to eq("Catequesis")
  end
  it "returns complex title when page_title is given" do
    expect(helper.full_title("Ayuda")).to eq("Ayuda | Catequesis")
  end
  it "returns complex title when page_title with spaces is given" do
    expect(helper.full_title("Datos de Contacto")).to eq("Datos de Contacto | Catequesis")
  end
  it "returns correctly the status in lock" do
    expect(ApplicationHelper.status_lock?).to be(false)
  end
  it "switches status in lock correctly in both directions" do
    old_status = ApplicationHelper.status_lock? # Status A
    ApplicationHelper.switch_lock # Change to status B
    expect(old_status).not_to be(ApplicationHelper.status_lock?) # Status A and B are different
    old_status = ApplicationHelper.status_lock? # Status B
    ApplicationHelper.switch_lock # Change to status A
    expect(old_status).not_to be(ApplicationHelper.status_lock?) # Status B and A are different
  end
end
