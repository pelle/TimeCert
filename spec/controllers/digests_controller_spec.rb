require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DigestsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    before(:each) do
      post 'create', :body=>"hello"
    end
    
    it "should be successful" do
      response.should redirect_to("/aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d")
    end
    
    it "should not yet have digest" do 
      $redis.get("sha1:aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d").should be_nil 
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @request.env['HTTP_REFERER'] = 'https://agree2.com/bla/bla/bla2'
      get 'show', :digest=>"a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should have digest" do
      $redis.get("sha1:a94a8fe5ccb19ba61c4c0873d391e987982fbbd3").should_not be_nil
    end
    
    it "should count the referrer host" do
      $redis.get("site:agree2.com").should == "1"
    end
    
  end
end
