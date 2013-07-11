
require 'spec_helper'

describe K4compiler::Config do

  describe "::DEFAULT_CONFIGURATION" do
    it "should instance is Hash" do
      K4compiler::Config::DEFAULT_CONFIGURATION.should be_instance_of(::Hash)
    end
  end


  describe "#new" do

    before do
      @config = K4compiler::Config.new
    end

    it "should instance is K4compiler::Config" do
      @config.should be_instance_of(K4compiler::Config)
    end

    # closure
    it "should has closure method" do
      @config.closure.should be_instance_of(::OpenStruct)
    end

    it "should has method 'closure.tartget' and the value is '**/*.js'" do
      @config.closure.target.should eq("**/*.js")
    end

    it "should has method 'closure.target_dir' and the value is nil" do
      @config.closure.target_dir.should be_nil
    end

    it "should has method 'closure.export_dir' and the value is nil" do
      @config.closure.export_dir.should be_nil
    end

    it "should has method 'closure.load_paths' and the value is empty array" do
      @config.closure.load_paths.should eq([])
    end

    it "should has method 'closure.level' and the value is ':advanced'" do
      @config.closure.level.should eq(:advanced)
    end


    # scss
    it "should has scss method" do
      @config.scss.should be_instance_of(::OpenStruct)
    end

    it "should has method 'scss.target' and the value is '**/*.scss'" do
      @config.scss.target.should eq("**/*.scss")
    end

    it "should has method 'scss.target_dir' and the value is nil" do
      @config.scss.target_dir.should be_nil
    end

    it "should has method 'scss.export_dir' and the value is nil" do
      @config.scss.export_dir.should be_nil
    end

    it "should has method 'scss.syntax' and the value is ':scss'" do
      @config.scss.syntax.should eq(:scss)
    end

    it "should has method 'scss.style' and the value is ':compressed'" do
      @config.scss.style.should eq(:compressed)
    end

    it "should has method 'scss.load_paths' and the value is empty array" do
      @config.scss.load_paths.should eq([])
    end

    # markdown
    it "should has markdown method" do
      @config.markdown.should be_instance_of(::OpenStruct)
    end
  end

  describe "#struct" do

    before do
      @config = K4compiler::Config.new
    end

    it "should instance is OpenStruct" do
      @config.struct.should be_instance_of(::OpenStruct)
    end

    it "should config has test_method" do
      @config.struct({:test_method => true}).test_method.should be_true
    end
  end

  describe "#build_struct_recursive" do
    before do
      @config = K4compiler::Config.new
    end

    it "should instance is OpenStruct" do
      hash = {
        :test => {
          :result => true
        },
      }
      @config.build_struct_recursive(hash).test.result.should be_true
    end
  end
end
