
require 'sass'

module K4compiler
  class Scss < Base

    # compile
    def compile(src)
      options = {
        :syntax => config.syntax,
        :style => config.style,
        :load_paths => config.load_paths,
      }
      engine = ::Sass::Engine.new(src, options)
      compiled = engine.render()
      return compiled.chomp
    end

    def config
      return super.scss
    end
  end
end
