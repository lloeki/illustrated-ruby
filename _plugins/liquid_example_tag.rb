module Jekyll
  class IncludeExampleTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @file = text
    end

    def render(context)
      #site = context.registers[:site]
      page = context.registers[:page]

      file = title_to_file(page.title) || @file
      validate_file_name(file)

      dir = locate_example_dir(context, file)

      #files = Dir.glob("#{dir}/*")

      #return unless path

      #add_include_to_dependency(site, path, context)

      render_example(dir, file)
    end

    def render_example(dir, file)
      <<-HTML
        #{read_example_file(dir, file, '.rb') { |f| render_example_io(f, '.rb') }}
        #{run_example_file(dir, file, '.rb') { |f| render_example_io(f, '.sh') }}
      HTML
    end

    def read_example_file(dir, file, ext)
      File.open(PathManager.join(dir, file) + ext) do |f|
        yield f
      end
    end

    def run_example_file(dir, file, ext)
      require 'open3'
      require 'stringio'

      cmd = ['ruby', PathManager.join(dir, file) + ext]

      Open3.popen2e(*cmd) do |_stdin, stdouterr, wait_thr|
        yield StringIO.new('$ ' << cmd.join(' ') << "\n" << stdouterr.read)

      ensure
        _rc = wait_thr.value
      end
    end

    def parse_example(io, ext)
      comment = []
      code = []
      pairs = []

      io.readlines.each do |line|
        case
        when newline?(line)
          pairs << [comment, code]
          comment, code = [], []
        when comment?(ext, line)
          comment << line
        else
          code << line
        end
      end
      pairs << [comment, code]

      pairs.map! do |comment, code|
        [uncomment(comment).join, code.join]
      end.reduce([]) do |a, (doc, code)|
        prev = a.last
        empty = code.empty?
        prev[1][2] = !empty unless prev.nil?

        a << [doc, [code, empty, false]]
      end
    end

    def render_example_io(io, ext)
      segment = parse_example(io, ext)

      require 'cgi'
      io.rewind

      out = +''

      out << '<table>'

      code_added = false
      segment.each do |doc, (code, empty, leading)|
        out << '<tr>'
        out << '<td class="docs">' << render_comment(doc, ext) << '</td>'
        out << '<td class="code' << (empty ? ' empty' : '') << (leading ? ' leading' : '') << '">'
        if ext == '.rb' && !empty && !code_added
          out << '<a href="https://try.ruby-lang.org/playground/#code=' << CGI.escape(io.read) << '&engine=cruby-3.2.0dev" target="_blank">'
          out << '<img class="run" title=Run code" src="https://www.ruby-lang.org/favicon.ico" />'
          out << '</a>'
          code_added = true
        end
        out << render_code(code, ext)
        out << '</td>'
        out << '</tr>'
      end

      out << '</table>'

      out
    end

    def uncomment(comment)
      comment.map! { |l| l.sub(/^\s*#/, '') }
    end

    def newline?(l)
      l.strip.empty?
    end

    def comment?(ext, l)
      case ext
      when '.rb' then l =~ /^\s*# / && true || false
      when '.sh' then l =~ /^\s*# / && true || false
      else false
      end
    end

    def render_comment(comment, _ext)
      return '' if comment.nil? || comment.strip.empty?

      converter = Jekyll.sites.first.converters.find { |c| c.is_a?(Jekyll::Converters::Markdown) }

      converter.convert(comment)
    end

    def render_code(code, ext)
      return '' if code.nil? || code.strip.empty?

      type = case ext
             when '.rb' then 'ruby'
             when '.sh' then 'console'
             else raise ArgumentError, "unhandled file type: #{ext}"
             end

      converter = Jekyll.sites.first.converters.find { |c| c.is_a?(Jekyll::Converters::Markdown) }

      converter.convert("```#{type}\n#{code}\n```\n")
    end


    def title_to_file(input)
      input.gsub(/\s+/, '_').downcase
    end

    def validate_file_name(file)
      if file.nil? || file.empty?
        raise ArgumentError, "invalid title or example name"
      end
    end

    def locate_example_dir(context, file)
      example_load_paths.each do |dir|
        path = PathManager.join(dir, file)
        return path if valid_example_dir?(path, file)
      end

      raise IOError, "could not locate example #{file.inspect} in #{example_load_paths}"
    end

    def example_load_paths
      ['examples']
    end

    def valid_example_dir?(path, dir)
      Dir.exist?(path) && File.exist?(PathManager.join(path, dir) + '.rb') # && File.exist?(PathManager.join(path, dir) + '.sh')
    end
  end
end

Liquid::Template.register_tag('include_example', Jekyll::IncludeExampleTag)
