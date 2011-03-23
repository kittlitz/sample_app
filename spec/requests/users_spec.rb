require 'spec_helper'

describe "Users" do
  describe "signup" do

    describe "failure" do
      it "should not create a new user" do
        lambda do
          visit signup_path
          fill_in "Name",            :with => ''
          fill_in "Email",           :with => ''
          fill_in "Password",        :with => ''
          fill_in "Confirmation",    :with => ''
          click_button
          response.should render_template('users/new')
          # Check for specific id within a div
          response.should have_selector('div#error_explanation')
        end.should_not change(User,:count)
      end
    end

    describe "success" do
      it "should create a new user" do
        lambda do
          visit signup_path
          fill_in "Name",            :with => 'New User'
          fill_in "Email",           :with => 'user@example.com'
          fill_in "Password",        :with => 'foobar'
          fill_in "Confirmation",    :with => 'foobar'
          click_button
          # Check for specific CSS class
          response.should have_selector('div.flash.success',
                                        :content => "Welcome")
          # Following happens after redirect.
          response.should render_template("users/show")
        end.should change(User,:count).by(1)
      end
    end

  end
end