require "k4compiler/version"
require 'active_support'

module K4compiler
  extend ActiveSupport::Autoload

  autoload :Config
  autoload :Closure
  autoload :Scss
  autoload :Markdown
  autoload :Tasks

  Tasks.install
end
