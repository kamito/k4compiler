
require 'redcarpet'

module K4compiler

  class MarkdownRenderer < ::Redcarpet::Render::HTML
    # @return [Hash]
    def self.options
      return {
        markdown_options: nil,
        renderer: nil,
        render_options: nil,
      }
    end

    # @override
    def block_code(code, lang=nil)
      lang ||= 'text'
      code = "\n<pre class=\"prettyprint lang-#{lang}\">\n#{code}</pre>\n"
      return code
    end
  end


  class Markdown < Base

    DEFAULT_MARKDOWN_OPTIONS = {
      autolink: true,
      fenced_code_blocks: true,
    }

    DEFAULT_RENDER_OPTIONS = {
      hard_wrap: true,
      link_attributes: {target: '_blank'}
    }

    # compile
    # @param [String|StringIO] src Source of markdown.
    def compile(src)
      src = src.read() if src.respond_to?(:read)
      markdown = Redcarpet::Markdown.new(renderer, markdown_options)
      rendered = markdown.render(src)
      return rendered
    end

    # @return [*|MarkdownRenderer]
    def renderer
      cls = config.renderer ||= MarkdownRenderer
      instance = cls.new(render_options)
      return instance
    end

    # @return [Hash]
    def markdown_options
      opt = DEFAULT_MARKDOWN_OPTIONS.dup
      opt = opt.update(config.markdown_options || {})
      return opt
    end

    # @return [Hash]
    def render_options
      opt = DEFAULT_RENDER_OPTIONS.dup
      opt = opt.update(config.render_options || {})
      return opt
    end

    # @return [OpenStruct]
    def config
      return super.markdown
    end
  end
end
