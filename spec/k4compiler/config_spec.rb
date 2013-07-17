
require 'spec_helper'

describe K4compiler::Config do

  describe "#default_options" do
    it "should instance is Hash" do
      config = K4compiler::Config.new
      config.default_options.should be_instance_of(::HashWithIndifferentAccess)
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

    it "should has method 'closure.load_paths' and the value is empty array" do
      @config.closure.load_paths.should be_instance_of(::Array)
    end

    it "should has method 'closure.level' and the value is ':advanced'" do
      @config.closure.level.should eq(:advanced)
    end

    it "should has method 'closure.compiler_jar' and the value is '../../third_party/closure-compiler-20130603/compiler.jar'" do
      compiler_path = File.expand_path(File.join(File.dirname(File.dirname(File.dirname(__FILE__))), 'third_party/closure-compiler-20130603/compiler.jar'))
      @config.closure.compiler_jar.should eq(compiler_path)
    end

    it "should has method 'closure.java_command' and the value is 'java'" do
      @config.closure.java_command.should eq('java')
    end

    it "should has method 'closure.python_command' and the value is 'python'" do
      @config.closure.python_command.should eq('python')
    end


    # scss
    it "should has scss method" do
      @config.scss.should be_instance_of(::OpenStruct)
    end


    it "should has method 'scss.syntax' and the value is ':scss'" do
      @config.scss.syntax.should eq(:scss)
    end

    it "should has method 'scss.style' and the value is ':compressed'" do
      @config.scss.style.should eq(:compressed)
    end

    it "should has method 'scss.load_paths' and the value is empty array" do
      @config.scss.load_paths.should be_instance_of(::Array)
    end

    # markdown
    it "should has markdown method" do
      @config.markdown.should be_instance_of(::OpenStruct)
    end

    it "should has method 'markdown.markdown_options' and the value is empth hash" do
      @config.markdown.markdown_options.should be_nil
    end

    it "should has method 'markdown.renderer' and the value is nil" do
      @config.markdown.renderer.should be_nil
    end

    it "should has method 'markdown.render_options' and the value is empth hash" do
      @config.markdown.render_options.should be_nil
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
