require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'digest/sha1'

describe Stamp do
  before(:each) do
    @stamp=Stamp.create :digest=>Digest::SHA1.hexdigest "Digest me, why don't ya"
  end

  it "should be valid" do
    @stamp.should be_valid
  end
end
