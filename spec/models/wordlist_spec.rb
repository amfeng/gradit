require 'spec_helper'

describe Wordlist do
  before(:each) do
    @valid_attributes = {
      :string => 
    }
  end

  it "should create a new instance given valid attributes" do
    Wordlist.create!(@valid_attributes)
  end
end
