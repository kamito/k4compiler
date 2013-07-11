require 'spec_helper'

describe K4compiler::Closure do

  describe "#compile" do

    before do
      @compiler = K4compiler::Closure.new
    end

    it "should return true" do
      @compiler.should be_instance_of(K4compiler::Closure)
    end
  end
end
