require 'spec_helper'

describe "sheets/index" do
  it "render" do
    render
    rendered.should have_selector("h1")
  end
end