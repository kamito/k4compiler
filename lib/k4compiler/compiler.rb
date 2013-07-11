module K4compiler
  class Compiler

    def initialize
    end

    # @return [K4compiler::Compiler]
    def setup(&block)
      yield(config) if block_given?
      return self
    end

    #
    # @return [K4Compiler::Config]
    def config
      @config_ ||= lambda {
        instance = ::K4compiler::Config.new
        instance
      }.call
      return @config_
    end

    # @return [K4compiler::Closure]
    def closure
      instance = ::K4compiler::Closure.new(config)
      return instance
    end

    # @return [K4compiler::Scss]
    def scss
      instance = ::K4compiler::Scss.new(config)
      return instance
    end

    # @return [K4compiler::Closure]
    def markdown
      instance = ::K4compiler::Markdown.new(config)
      return instance
    end
  end
end
