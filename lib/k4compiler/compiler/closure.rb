module K4compiler
  class Closure < Base

    # @return [Hash]
    def self.options
      return {
        load_paths: [],
        with_closure: false,
        # common options
        level: :advanced,
        java_command: 'java',
        compiler_jar: File.join(::K4compiler::Config::THIRD_PARTY_DIR, 'closure-compiler-20130603/compiler.jar'),
        # with closure options
        python_command: 'python',
        closure_builder: File.join(::K4compiler::Config::THIRD_PARTY_DIR, 'closure-library/closure/bin/build/closurebuilder.py'),
        closure_path: File.join(::K4compiler::Config::THIRD_PARTY_DIR, 'closure-library'),
        compile_output_wrapper: "(function(){%output%})();",
        compile_defined_options: ['goog.DEBUG=false;'],
      }
    end

    # @param [String] filepath JavaScript source file path.
    def compile(*args)
      result = nil
      if config.with_closure
        command = build_compile_command_with_closure(*args)
        puts command
        result = IO.popen('-', 'r') {|pipe| pipe ? pipe.read : exec(*command) }
      else
        command = build_compile_command_without_closure(*args)
        result = system(command)
      end
      return result
    end

    # @param [String] namespace JavaScript file namespace.
    def build_compile_command_with_closure(namespace)
      compile_mode = config.level == :script ? :script : :compiled

      puts config.load_paths

      com = []
      com << config.python_command
      com << config.closure_builder
      com << "-o #{compile_mode.to_s}"
      com << "-c #{config.compiler_jar}"
      com << "--namespace=\"#{namespace}\""
      com << "--root=#{config.closure_path}"
      config.load_paths.each do |path|
        com << "--root=#{path}"
      end
      # compiler options
      com << "-f --compilation_level=#{compilation_level}"
      com << "-f --output_wrapper=\"#{config.compile_output_wrapper}\""
      config.compile_defined_options.each do |define_opt|
        com << "-f --define=#{define_opt}"
      end
      return com.join(' ').chomp
    end

    # @param [String] target_filepath Compile file path.
    def build_compile_command_without_closure(target_filepath, output_filepath)
      if config.level == :script
        com = "cp -a #{target_filepath} #{output_filepath}"
        return com
      else
        com = [config.java_command]
        com << "-jar #{config.compiler_jar}"
        com << "--js #{target_filepath}"
        com << "--js_output_file #{output_filepath}"
        com << "--compilation_level #{compilation_level}"
        return com.join(' ').chomp
      end
    end

    # @return [String]
    def compilation_level
      return case config.level
             when :script then 'SIMPLE_OPTIMIZATIONS'
             when :simple then 'SIMPLE_OPTIMIZATIONS'
             when :advanced then 'ADVANCED_OPTIMIZATIONS'
             else 'ADVANCED_OPTIMIZATIONS'
             end
    end

    # @return [OpenStruct]
    def config
      return super.closure
    end
  end
end
