require 'spec_helper'

describe K4compiler::Scss do

  describe "#compile" do

    before do
      @compiler = K4compiler::Scss.new
    end

    it "should return true" do
      @compiler.should be_instance_of(K4compiler::Scss)
    end
  end
end
