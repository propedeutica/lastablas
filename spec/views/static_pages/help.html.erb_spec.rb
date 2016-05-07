require 'rails_helper'

RSpec.describe "static_pages/help.html.erb", type: :view do
  it "should render static_pages/help" do
    render
    expect(view).to render_template("static_pages/help")
  end
end
