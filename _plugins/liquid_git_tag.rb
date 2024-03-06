module Jekyll
  class GitTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @key = text.split(' ', 2).first
    end

    def render(context)
      case @key.to_sym
      when :run_id, :ref, :commit, :short
        GitTag.cache(@key) { send(@key) }
      end
    end

    private

    def run_id
      ENV['GITHUB_RUN_ID'] || 'dev'
    end

    def ref
      ENV['GITHUB_REF'] || `git rev-parse --abbrev-ref HEAD`
    end

    def commit
      ENV['GITHUB_SHA'] || `git rev-parse HEAD`
    end

    def short
      commit[0, 7]
    end

    # HACK: dumb cache, does not reset
    def self.cache(key)
      (@cache ||= {}).fetch(key) { |k| @cache[k] = yield }
    end
  end
end

Liquid::Template.register_tag('git', Jekyll::GitTag)
