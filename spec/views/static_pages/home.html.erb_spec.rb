require 'rails_helper'

RSpec.describe "static_pages/home.html.erb", type: :view do
  it "should render /static_pages/home" do
    render
    expect(view).to render_template("static_pages/home")
  end
end
