require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GithubController do
  render_views
  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end
  
  it "should not have timestamps yet for before sha" do
    $redis.get("sha1:aaf4c61ddcc5e8a2dabede0f3b482cd9aea94341").should be_nil
  end

  describe "POST 'create'" do
    before(:each) do
      post 'create', :payload => {
        :before     => "aaf4c61ddcc5e8a2dabede0f3b482cd9aea94341",
        :after      => "aaf4c61ddcc5e8a2dabede0f3b482cd9aea94342",
        :commits    => [{
              :id        => "aaf4c61ddcc5e8a2dabede0f3b482cd9aea94343"
            },{
              :id        => "aaf4c61ddcc5e8a2dabede0f3b482cd9aea94344"
            }],
        :repository =>{ :url => "http://github.com/pelle/timecert"}
        }.to_json
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should have timestamps for before sha" do
      $redis.get("sha1:aaf4c61ddcc5e8a2dabede0f3b482cd9aea94341").should_not be_nil 
    end
    
    it "should have timestamps for after sha" do
      $redis.get("sha1:aaf4c61ddcc5e8a2dabede0f3b482cd9aea94342").should_not be_nil 
    end
    
    it "should have timestamps for first commit sha" do
      $redis.get("sha1:aaf4c61ddcc5e8a2dabede0f3b482cd9aea94343").should_not be_nil
    end
    
    it "should have timestamps for last commit sha" do
      $redis.get("sha1:aaf4c61ddcc5e8a2dabede0f3b482cd9aea94344").should_not be_nil
    end
    
    it "should record site" do
      $redis.get("git:http://github.com/pelle/timecert").should == "1"
    end
  end
end
