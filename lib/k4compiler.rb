require "k4compiler/version"
require 'active_support'

module K4compiler
  extend ActiveSupport::Autoload

  autoload :Compiler
  autoload :Config

  # compilers
  autoload_under('compiler') do
    autoload :Base
    autoload :Closure
    autoload :Scss
    autoload :Markdown
    autoload :MarkdownRenderer, 'k4compiler/compiler/markdown.rb'
  end

  # @return [K4compiler::Compiler]
  def self.setup(&block)
    compiler = Compiler.new
    compiler.setup(&block)
    return compiler
  end
end
