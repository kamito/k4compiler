
require 'ostruct'

module K4compiler
  class Config

    # default configuration
    DEFAULT_CONFIGURATION = {
      closure: {
        target: '**/*.js',
        target_dir: nil,
        export_dir: nil,
        load_paths: [],
        level: :advanced,
      },
      scss: {
        target: '**/*.scss',
        target_dir: nil,
        export_dir: nil,
        load_paths: [],
        syntax: :scss,
        style: :compressed,
      },
      markdown: {

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
