require 'spec_helper'

describe K4compiler::Scss do

  describe "#new" do

    before do
      config = K4compiler::Config.new
      @compiler = K4compiler::Scss.new(config)
    end

    it "should instance is K4compiler::Scss" do
      @compiler.should be_instance_of(K4compiler::Scss)
    end
  end
end
