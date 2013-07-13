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

  describe "#compile" do
    it "should make compressed css" do
      config = K4compiler::Config.new
      compiler = K4compiler::Scss.new(config)
      scss = <<__SCSS__
body {
    background-color: #000000;
    color: #FFFFFF;
    font-size: 10pt;
    #contents {
        background-color: #FFFFFF;
        color: #000000;
    }
}
__SCSS__
      result_css = "body{background-color:#000000;color:#FFFFFF;font-size:10pt}body #contents{background-color:#FFFFFF;color:#000000}"
      compiler.compile(scss).should eq(result_css)
    end

    it "should make compact css" do
      config = K4compiler::Config.new
      config.scss.style = :compact
      compiler = K4compiler::Scss.new(config)
      scss = <<__SCSS__
body {
    background-color: #000000;
    color: #FFFFFF;
    font-size: 10pt;
    #contents {
        background-color: #FFFFFF;
        color: #000000;
    }
}
__SCSS__
      result_css = <<__RESULT__
body { background-color: #000000; color: #FFFFFF; font-size: 10pt; }
body #contents { background-color: #FFFFFF; color: #000000; }
__RESULT__
      compiler.compile(scss).should eq(result_css.chomp)
    end

    it "should make imported css" do
      sample_dir = File.expand_path(File.join(File.dirname(__FILE__), 'scss'))

      config = K4compiler::Config.new
      config.scss.load_paths << sample_dir
      compiler = K4compiler::Scss.new(config)

      scss = File.read(File.join(sample_dir, 'sample.scss'))
      result_css = "body{background-color:#000000;color:#FFFFFF;font-size:10pt}body #contents{background-color:#FFFFFF;color:#000000}"
      compiler.compile(scss).should eq(result_css.chomp)
    end
  end
end
