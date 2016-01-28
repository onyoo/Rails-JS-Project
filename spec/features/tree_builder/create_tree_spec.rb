require 'spec_helper'
require 'pry'
describe "creating a tree with one category, one child subject, and one sub-child resource" do
  context "form has required fields" do

    it "should have a form with nested fields" do

      visit home_path
      click_link("Build a tree of resources...")

      expect(page).to have_css("form.new_category")
      # expect(page).to have_css("div#subject_tree")
    end
  end
end