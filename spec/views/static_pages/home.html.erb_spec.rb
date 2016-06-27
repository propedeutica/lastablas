require 'rails_helper'

RSpec.describe "static_pages/home.html.erb", type: :view do
  pending "should render /static_pages/home when authenticated" do
    render
    expect(view).to render_template("static_pages/home")
  end
  pending "should redirect to #log_in when not authenticated"
end
