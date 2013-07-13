
require 'ostruct'

module K4compiler
  class Config

    # default configuration
    DEFAULT_CONFIGURATION = {
      closure: {
        load_paths: [],
        level: :advanced,
      },
      scss: {
        load_paths: [],
        syntax: :scss,
        style: :compressed,
      },
      markdown: {
        markdown_options: nil,
        renderer: nil,
        render_options: nil,
      }
    }

    def initialize
      @root_ = build_struct_recursive(DEFAULT_CONFIGURATION)
    end

    def struct(*args)
      structure = OpenStruct.new(*args)
      return structure
    end

    # @param [Hash] hash configuration hash
    def build_struct_recursive(hash={})
      struct_hash = {}
      hash.each do |key, val|
        if val.is_a?(::Hash)
          val = build_struct_recursive(val)
        end
        struct_hash[key] = val
      end
      return struct(struct_hash)
    end

    def method_missing(method, *args)
      if @root_.respond_to?(method)
        @root_.send(method, *args)
      else
        raise ::NoMethodError.new("undefined local variable or method '#{method}'")
      end
    end
  end
end
