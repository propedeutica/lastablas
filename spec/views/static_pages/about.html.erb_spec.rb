require 'rails_helper'

RSpec.describe "static_pages/about.html.erb", type: :view do
  it "should render static_pages/about" do
    render
    expect(view).to render_template("static_pages/about")
  end
end
