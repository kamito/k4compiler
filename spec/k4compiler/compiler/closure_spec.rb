require 'spec_helper'

describe K4compiler::Closure do

  describe "#new" do
    it "should instance is K4compiler::Closure" do
      config = K4compiler::Config.new
      compiler = K4compiler::Closure.new(config)
      compiler.should be_instance_of(K4compiler::Closure)
    end
  end

  describe "#config" do
    it "should instance of OpenStruct" do
      config = K4compiler::Config.new
      compiler = K4compiler::Closure.new(config)
      compiler.config.should be_instance_of(::OpenStruct)
    end

    it "should has configuration 'java_command' the value 'java'" do
      config = K4compiler::Config.new
      compiler = K4compiler::Closure.new(config)
      compiler.config.java_command.should eq('java')
    end

    it "should has configuration 'with_closure' the value true" do
      config = K4compiler::Config.new
      compiler = K4compiler::Closure.new(config)
      compiler.config.with_closure.should be_false
    end
  end

  describe "#compilation_level" do
    it "should SIMPLE_OPTIMIZATIONS" do
      config = K4compiler::Config.new
      config.closure.level = :script
      compiler = K4compiler::Closure.new(config)
      compiler.compilation_level.should eq("SIMPLE_OPTIMIZATIONS")
    end

    it "should SIMPLE_OPTIMIZATIONS" do
      config = K4compiler::Config.new
      config.closure.level = :simple
      compiler = K4compiler::Closure.new(config)
      compiler.compilation_level.should eq("SIMPLE_OPTIMIZATIONS")
    end

    it "should ADVANCED_OPTIMIZATIONS" do
      config = K4compiler::Config.new
      config.closure.level = :advanced
      compiler = K4compiler::Closure.new(config)
      compiler.compilation_level.should eq("ADVANCED_OPTIMIZATIONS")
    end
  end

  describe "#build_compile_command_without_closure" do
    it "should compile command" do
      config = K4compiler::Config.new
      compiler = K4compiler::Closure.new(config)
      compiler.build_compile_command_without_closure('hello.js', 'hello-compiled.js') \
        .should eq("java -jar #{config.closure.compiler_jar} --js hello.js --js_output_file hello-compiled.js --compilation_level ADVANCED_OPTIMIZATIONS")
    end

    it "should copy command" do
      config = K4compiler::Config.new
      config.closure.level = :script
      compiler = K4compiler::Closure.new(config)
      compiler.build_compile_command_without_closure('hello.js', 'hello-compiled.js') \
        .should eq("cp -a hello.js hello-compiled.js")
    end
  end

  describe "#build_compile_command_with_closure" do
    it "should executable command" do
      config = K4compiler::Config.new
      config.closure.with_closure = true
      config.closure.load_paths << File.expand_path(File.dirname(__FILE__))
      compiler = K4compiler::Closure.new(config)
      compiler.build_compile_command_with_closure('sample.App') \
        .should eq("python #{config.closure.closure_builder} -o compiled -c #{config.closure.compiler_jar} --namespace=\"sample.App\" --root=#{config.closure.closure_path} --root=#{File.expand_path(File.dirname(__FILE__))} -f --compilation_level=ADVANCED_OPTIMIZATIONS -f --output_wrapper=\"(function(){%output%})();\" -f --define=goog.DEBUG=false;")
    end
  end

  describe "#compile" do
    describe "with_closure=false (default)" do
      describe "compilation_level=:advanced (default)" do
        before(:all) do
          config = K4compiler::Config.new
          compiler = K4compiler::Closure.new(config)
          @source_path = File.expand_path(File.join(File.dirname(__FILE__), 'closure/src/hello.js'))
          @compiled_path = File.join(File.dirname(File.dirname(@source_path)), 'compiled/hello-compiled-advanced.js')
          compiler.compile(@source_path, @compiled_path)
        end

        it "should created 'closure/compiled/hello-compiled-advanced.js'" do
          File.exists?(@compiled_path).should be_true
        end

        it "should compiled source" do
          File.read(@compiled_path).should eq("(function(){function a(){this.a=\"Hello Closure compiler\"}a.prototype.alert=function(){alert(this.a)};(new a).alert()})();\n")
        end
      end

      describe "compilation_level=:script" do
        before(:all) do
          config = K4compiler::Config.new
          config.closure.level = :script
          compiler = K4compiler::Closure.new(config)
          @source_path = File.expand_path(File.join(File.dirname(__FILE__), 'closure/src/hello.js'))
          @compiled_path = File.join(File.dirname(File.dirname(@source_path)), 'compiled/hello-compiled-script.js')
          compiler.compile(@source_path, @compiled_path)
        end

        it "should created 'closure/compiled/hello-compiled-script.js'" do
          File.exists?(@compiled_path).should be_true
        end

        it "should compiled source" do
          File.read(@compiled_path).should eq(File.read(@source_path))
        end
      end

      describe "compilation_level=:simple" do
        before(:all) do
          config = K4compiler::Config.new
          config.closure.level = :simple
          compiler = K4compiler::Closure.new(config)
          @source_path = File.expand_path(File.join(File.dirname(__FILE__), 'closure/src/hello.js'))
          @compiled_path = File.join(File.dirname(File.dirname(@source_path)), 'compiled/hello-compiled-simple.js')
          compiler.compile(@source_path, @compiled_path)
        end

        it "should created 'closure/compiled/hello-compiled-simple.js'" do
          File.exists?(@compiled_path).should be_true
        end

        it "should compiled source" do
          File.read(@compiled_path).should eq("(function(){var a=function(){this.var_=\"Hello Closure compiler\"};a.prototype.alert=function(){alert(this.var_)};(new a).alert()})();\n")
        end
      end
    end

    describe "with_closure=true" do
      describe "compilation_level=:script" do
        it "should compile command" do
          config = K4compiler::Config.new
          config.closure.with_closure = true
          config.closure.level = :script
          config.closure.load_paths << File.expand_path(File.join(File.dirname(__FILE__), 'closure/src'))
          compiler = K4compiler::Closure.new(config)
          source_path = File.expand_path(File.join(File.dirname(__FILE__), 'closure/src/hello-with-closure.js'))
          compiled_path = File.join(File.dirname(File.dirname(source_path)), 'compiled/hello-with-closure-compiled-script.js')
          compiled_source = compiler.compile('sample.App')
          File.read(compiled_path).should eq(compiled_source)
        end
      end
    end
  end
end
