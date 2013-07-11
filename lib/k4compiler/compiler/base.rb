module K4compiler

  class Base

    def initialize(config)
      @config_ = config
    end

    # @return [K4compiler::Config]
    def config
      return @config_
    end

    # compile
    def compile
      raise NotImplementedError.new("Compile method implement in child classes.")
    end
  end
end