# Strings are a fundamental data structure of Ruby. Let's do a quick tour.

# Here's a simple string.
p "foo bar baz"

# Individual characters are accessed with square brackets. Strings are zero-indexed.
p "foo bar baz"[0]

# An out-of-bounds access returns `nil`.
p "foo bar baz"[20]

# Concatenation of arrays is done with `+`, which creates a new string.
p "foo" + "bar" + "baz"

# A string can be appended to, which modifies the original string in place.
p "qu" << "uuuu" << "ux"

# Strings can be interpolated. The content of the curly braces is a Ruby
# expression.
p "one: #{1}, two: #{1+1}"

# Ruby processes escape sequences in double-quoted strings.
p "newline: \n, double quote: \""

# This allows escaping out of interpolation.
p "no interpolation: \#{42}"

# Ruby process neither escape sequences nor interpolation in single-quoted
# strings.
p 'backslash-n: \n, no interpolation: #{42}'

# Strings can be written in other ways than with quotes.

# `%q` (short for "quote") creates a string.
p %q[oh 'my' "string"]

# The delimiter can be changed.
p %q{string with curly braces}

# `%q` is equivalent to single quotes, and `%Q` is equivalent to double quotes.
p %q{backslash-n: \n}
p %Q{newline: \n forty-two: #{42}}

# `%{}` is equivalent to `%Q`
p %{newline: \n forty-two: #{42}}

# Multiline strings can be written using a heredoc. The closing identifier must not be indented.
puts <<EOS
first line: #{1}
second line: #{2}
EOS

# The closing identifier and content can be kept flush with `<<-`.
  puts <<-EOS
  first line: #{1}
  second line: #{2}
  EOS

# Content indentation can be stripped with `<<~`.
puts <<~EOS
  level 1
    level 2
      level 3
  level 1
    level 2
EOS

# Heredocs can be single-quoted.
p <<'EOS'
first line: \n
second line: #{42}
EOS
