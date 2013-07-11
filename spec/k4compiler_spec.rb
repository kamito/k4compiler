require 'spec_helper'

describe K4compiler do

  describe ".setup" do

    it "should return K4compiler instance" do
      K4compiler.setup.should be_instance_of(K4compiler::Compiler)
    end

    it "should config instance in block at block given" do
      K4compiler.setup do |config|
        config.should be_instance_of(K4compiler::Config)
      end
    end
  end
end
