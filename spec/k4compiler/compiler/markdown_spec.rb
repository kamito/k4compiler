require 'spec_helper'
require 'redcarpet'

describe K4compiler::Markdown do

  describe "#new" do
    it "should instance is K4compiler::Markdown" do
      config = K4compiler::Config.new
      compiler = K4compiler::Markdown.new(config)
      compiler.should be_instance_of(K4compiler::Markdown)
    end
  end

  describe "#markdown_options" do
    it "should is options hash" do
      config = K4compiler::Config.new
      compiler = K4compiler::Markdown.new(config)
      compiler.markdown_options.should eq({autolink: true, fenced_code_blocks: true})
    end
  end

  describe "#render_options" do
    it "should is options hash" do
      config = K4compiler::Config.new
      compiler = K4compiler::Markdown.new(config)
      compiler.render_options.should eq({hard_wrap: true,link_attributes: {target: '_blank'}})
    end
  end

  describe "#compile" do
    it "should compiled html with 'Redcarpet::Render::HTML'" do
      # markdown
      markdown = <<__MARKDOWN__
# K4compiler #
## compile ##
compiling
__MARKDOWN__

      # result
      result = <<__RESULT__
<h1>K4compiler</h1>

<h2>compile</h2>

<p>compiling</p>
__RESULT__

      config = K4compiler::Config.new
      config.markdown.renderer = ::Redcarpet::Render::HTML
      compiler = K4compiler::Markdown.new(config)
      compiler.compile(markdown).should eq(result)
    end

    it "should compiled html with default renderer" do
      config = K4compiler::Config.new
      compiler = K4compiler::Markdown.new(config)
      compiler.compile(MARKDOWN_SRC).should eq(MARKDOWN_RESULT)
    end
  end
end


describe K4compiler::MarkdownRenderer do

  describe "#block_code"do
    it "should pre tag and added css class 'prettyprint'" do
      renderer = K4compiler::MarkdownRenderer.new
      renderer.block_code(MARKDOWN_RUBY_CODE, 'ruby').should eq(MARKDOWN_RUBY_CODE_RESULT)
    end
  end
end

MARKDOWN_RUBY_CODE = <<__RUBY_CODE__
#!/usr/bin/env ruby

class Markdown
  def compile(src)
    # Do compile
    return src
  end
end
__RUBY_CODE__

MARKDOWN_RUBY_CODE_RESULT = <<__RUBY_RESULT__

<pre class="prettyprint lang-ruby">
#!/usr/bin/env ruby

class Markdown
  def compile(src)
    # Do compile
    return src
  end
end
</pre>
__RUBY_RESULT__

MARKDOWN_SRC = <<__MARKDOWN__
# K4compiler #
## paragraph ##
block code
new line

compiling
test

## link ##
http://www.google.com

## code block ##

```ruby
#!/usr/bin/env ruby

class Markdown
  def compile(src)
    # Do compile
    return src
  end
end
```
__MARKDOWN__
# <<__MARKDOWN__

# result
MARKDOWN_RESULT = <<__RESULT__
<h1>K4compiler</h1>

<h2>paragraph</h2>

<p>block code<br>
new line</p>

<p>compiling<br>
test</p>

<h2>link</h2>

<p><a href="http://www.google.com" target="_blank">http://www.google.com</a></p>

<h2>code block</h2>

<pre class="prettyprint lang-ruby">
#!/usr/bin/env ruby

class Markdown
  def compile(src)
    # Do compile
    return src
  end
end
</pre>
__RESULT__
