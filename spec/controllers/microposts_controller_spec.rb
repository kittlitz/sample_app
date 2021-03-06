require 'spec_helper'

describe MicropostsController do
  render_views

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end

  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = {:content => ""}
      end

      it "should not create a micropost" do
        lambda do
          post :create, :micropost => @attr
        end.should_not change(Micropost, :count)
      end

      it "should re-render the home page" do
        post :create, :micropost => @attr
        response.should render_template('pages/home')
      end

    end

    describe "success" do

      before(:each) do
        @attr = {:content => "blahdebla debalhdeblah"}
      end

      it "should create a micropost" do
        lambda do
          post :create, :micropost => @attr
        end.should change(Micropost,:count).by(1)
      end

      it "should redirect to the root path" do
        post :create, :micropost => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash success" do
        post :create, :micropost => @attr
        flash[:success].should =~ /Micropost created/
      end
    end

  end

  describe "DELETE 'destroy'" do

    describe "unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        @wrong_user = Factory(:user,
                              :email => Factory.next(:email))
        @micropost = Factory(:micropost, :user => @user)
        test_sign_in(@wrong_user)
      end

      it "should deny access" do
        delete :destroy, :id => @micropost
        response.should redirect_to(root_path)
      end
    end

    describe "authorized user" do

      before(:each) do
        @user = Factory(:user)
        @micropost = Factory(:micropost, :user => @user)
        test_sign_in(@user)
      end

      it "should delete the micropost" do
        lambda do
          delete :destroy, :id => @micropost
          flash[:success].should =~ /deleted/
          response.should redirect_to(root_path)
        end.should change(Micropost,:count).by(-1)
      end

    end

  end
end
