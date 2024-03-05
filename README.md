# The *Illustrated Ruby* guide

Content and build toolchain for [Illustrated Ruby](https://lloeki.github.io/illustrated-ruby/),
a site that teaches Ruby via annotated example programs.

### Overview

The Illustrated Ruby site is built by extracting code and comments from source
files in `examples` and rendering them using templates in `_examples` into a
static `_site` directory. The program used is Jekyll, extended with additional
example generation in `_plugin`, as well as dependencies specified in the
`Gemfile` file.

The built `_site` directory can be served by any static content system. The
production site uses GitHub Pages, for example.

### Building

To build the site you'll need Ruby installed. Run:

```console
$ bundle exec jekyll build
```

To build continuously in a loop:

```console
$ bundle exec jekyll build --watch
```

To see the site locally:

```
$ bundle exec jekyll serve --livereload
```

and open `http://127.0.0.1:4000/` in your browser.

You can also specify a base URL:

```
$ bundle exec jekyll serve --livereload --baseurl /illustrated-ruby
```

and open `http://127.0.0.1:4000/illustrated-ruby` in your browser.

### Publishing

Publishing is achieved via GitHub Actions.

See `.github/workflows/jekyll.yml`.

### License

This work is copyright Loic Nageleisen and licensed under a
[Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/).

### Thanks

Thanks to [Mark McGranaghan](https://github.com/mmcgrana) for [Go by
Example](https://gobyexample.com), which inspired this project. Bits of the Go
by Example project are used and are licensed under a [Creative Commons
Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/).
