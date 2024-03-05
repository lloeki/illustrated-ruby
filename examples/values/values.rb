# Ruby has various value types including strings,
# integers, floats, booleans, etc. Here are a few
# basic examples.

# Strings, which can be added together with `+`, or appended to with `<<`.
puts "ruby" << "-lang" + ".org"

# Integers and floats. Here we use interpolation to embed stringified values.
puts "1+1 = #{ 1 + 1 }"
puts "7.0/3.0 = #{ 7.0 / 3.0 }"

# Booleans, with boolean operators as you'd expect.
puts true && false
puts true || false
puts !true
