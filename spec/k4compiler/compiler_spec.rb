require 'spec_helper'

describe K4compiler::Compiler do

  describe "#new" do
    before do
      @compiler = K4compiler::Compiler.new
    end

    it "should instance is K4compiler::Compiler" do
      @compiler.should be_instance_of(K4compiler::Compiler)
    end
  end


  describe "#config" do
    before do
      @compiler = K4compiler::Compiler.new
    end

    it "should has config instance" do
      @compiler.config.should be_instance_of(K4compiler::Config)
    end
  end


  describe "#closure" do
    before do
      @compiler = K4compiler::Compiler.new
    end

    it "should has closure instance" do
      @compiler.closure.should be_instance_of(K4compiler::Closure)
    end
  end


  describe "#scss" do
    before do
      @compiler = K4compiler::Compiler.new
    end

    it "should has scss instance" do
      @compiler.scss.should be_instance_of(K4compiler::Scss)
    end
  end


  describe "#markdown" do
    before do
      @compiler = K4compiler::Compiler.new
    end

    it "should has markdown instance" do
      @compiler.markdown.should be_instance_of(K4compiler::Markdown)
    end
  end


  describe "#setup" do
    before do
      @compiler = K4compiler::Compiler.new
    end

    it "should return self" do
      @compiler.setup.should be_instance_of(K4compiler::Compiler)
    end

    it "should config instance in block at block given" do
      @compiler.setup do |config|
        config.should be_instance_of(K4compiler::Config)
      end
    end
  end
end
