require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Stamp do
  
  describe "Timestamping" do
    before(:each) do
      @stamp=Stamp.new "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
    end
    
    it "should have a timestamp" do
      @stamp.timestamp.should_not be_nil
    end
    
    it "should have a utc" do
      @stamp.utc.should_not be_nil
    end
    
    it "be stored in redis" do
      $redis.get("sha1:a94a8fe5ccb19ba61c4c0873d391e987982fbbd3") 
    end
        
  end
  
  describe "by_digest" do
    before(:each) do
      @stamp=Stamp.by_digest "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
    end
    
    it "should description" do
      @stamp.digest.should == "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
    end
    
    it "should have a timestamp" do
      @stamp.timestamp.should_not be_nil
    end

    it "should find created stamp by digest" do
      Stamp.find_by_digest(@stamp.digest).should == @stamp
    end
    
    describe "second time" do
      before(:each) do
        @stamp2=Stamp.by_digest "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
      end
      
      it "should be the same as previous" do
        @stamp2.should==@stamp
      end
      
      it "should description" do
        @stamp2.digest.should == "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
      end
    

      it "should have a timestamp" do
        @stamp2.timestamp.should_not be_nil
      end
    end
  end
  
  
  describe "Formats" do
    before(:each) do
      @stamp=Stamp.by_digest "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"
    end
    
    describe "yaml" do
      it "should parse the yaml" do
        YAML.load( @stamp.to_yaml).should=={:timestamp=>@stamp.utc.to_s,:digest => "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3"}
      end
    end
    
    describe "json" do
      it "should parse the json" do
        require 'json'
        JSON.parse( @stamp.to_json).should=={'digest' => "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3", 'timestamp'=>@stamp.utc.to_s}
      end
    end
    
  end
end