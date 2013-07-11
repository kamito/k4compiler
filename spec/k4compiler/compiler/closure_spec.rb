require 'spec_helper'

describe K4compiler::Closure do

  describe "#new" do

    before do
      config = K4compiler::Config.new
      @compiler = K4compiler::Closure.new(config)
    end

    it "should instance is K4compiler::Closure" do
      @compiler.should be_instance_of(K4compiler::Closure)
    end
  end
end
