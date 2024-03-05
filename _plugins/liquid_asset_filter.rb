module Jekyll
  module ExampleFileFilter
    def example_file(input)
      input.gsub(/\s+/, '_').downcase
    end
  end
end

Liquid::Template.register_filter(Jekyll::ExampleFileFilter)
