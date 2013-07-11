require 'spec_helper'

describe K4compiler::Markdown do

  describe "#new" do

    before do
      config = K4compiler::Config.new
      @compiler = K4compiler::Markdown.new(config)
    end

    it "should instance is K4compiler::Markdown" do
      @compiler.should be_instance_of(K4compiler::Markdown)
    end
  end
end
