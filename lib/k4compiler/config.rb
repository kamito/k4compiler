
require 'ostruct'
require 'active_support/core_ext/string'
require 'active_support/core_ext/hash'


module K4compiler
  class Config

    THIRD_PARTY_DIR = File.expand_path(File.join(File.dirname(File.dirname(File.dirname(__FILE__))), 'third_party'))


    def initialize
      @root_ = build_struct_recursive(default_options)
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

    # @return [Hash]
    def default_options
      options = {}
      ignore_files = ['.', '..', 'base.rb']
      compiler_path = File.join(File.dirname(__FILE__), 'compiler')
      Dir.foreach(compiler_path) do |entry|
        unless ignore_files.include?(entry)
          basename = File.basename(entry).gsub(/\.rb$/, '')
          class_name = basename.camelize
          eval_method = "K4compiler::#{class_name}.options"
          options[basename] = eval(eval_method)
        end
      end
      options = options.with_indifferent_access
      return options
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
