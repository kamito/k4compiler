require 'spec_helper'

describe K4compiler::Config do

  describe "#compile" do

    before do
      @compiler = K4compiler::Config.new
    end

    it "should return true" do
      @compiler.should be_instance_of(K4compiler::Config)
    end
  end
end
