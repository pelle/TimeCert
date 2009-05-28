require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DigestsController do

  it "should use DigestsController" do
    controller.should be_an_instance_of(DigestsController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create',:body=>"hello"
      response.should redirect_to("/aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d")
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show',:digest=>"a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
      response.should be_success
    end
  end
end
