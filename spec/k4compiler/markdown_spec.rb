require 'spec_helper'

describe K4compiler::Markdown do

  describe "#compile" do

    before do
      @compiler = K4compiler::Markdown.new
    end

    it "should return true" do
      @compiler.should be_instance_of(K4compiler::Markdown)
    end
  end
end
