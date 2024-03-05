# Arrays are a fundamental data structure of Ruby. Let's do a quick tour.

# Here's a simple array.
p ["foo", "bar", "baz"]

# Individual items are accessed with square brackets. Arrays are zero-indexed.
p ["foo", "bar", "baz"][0]

# An out-of-bounds access returns `nil`.
p ["foo", "bar", "baz"][3]

# Arrays can mix types.
p [1, "a", :b]

# Concatenation of arrays is done with `+`, which creates a new array.
p [1, 2] + [3, 4]

# An arrays can be appended to, which modifies the original array in place.
p [5, 6] << 7 << 8

# The `*` operator destructures an array.
p ["this", "is", *["an", "array"]]

# Arrays can be written in other ways than with square brackets. `%w` creates
# arrays from bare words, each one becoming a string.
p %w[array of bare words]

# The delimiter can be changed.
p %w{array with curly braces}

# `%w` is equivalent to single quotes, and `%W` is equivalent to double quotes.
p %w{backslash-n: \n}
p %W{newline: \n forty-two: #{42}}

# `%i` and `%I` create arrays of symbols
p %i{oh my! symbols!}
