require 'spec_helper'

describe K4compiler::Base do

  describe "#new" do
    before do
      config = K4compiler::Config.new
      @compiler = K4compiler::Base.new(config)
    end

    it "should instance is K4compiler::Base" do
      @compiler.should be_instance_of(K4compiler::Base)
    end
  end

  describe "#compile" do
    before do
      config = K4compiler::Config.new
      @compiler = K4compiler::Base.new(config)
    end

    it "should compile raise NotImplementedError" do
      lambda {
        @compiler.compile
      }.should raise_error(NotImplementedError)
    end
  end


  describe "#config" do
    before do
      config = K4compiler::Config.new
      @compiler = K4compiler::Base.new(config)
    end

    it "should instance of K4compiler::Config" do
      @compiler.config.should be_instance_of(K4compiler::Config)
    end
  end
end
