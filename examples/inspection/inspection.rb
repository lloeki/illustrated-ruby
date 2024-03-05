# Up until now we have used `puts` to print values out. As we move forward, we
# will find this is too limited to properly inspect some values.

# Where `puts` uses the string contents to produce output, `p` outputs a
# representation of the value.
puts "this uses `puts`"
p "this uses `p`"

# Behind the scenes, `puts` uses the `to_s` method to transform any object into
# a string. These two lines are equivalent.
puts 1
puts 2.to_s

# Interpolation also makes use of `to_s`, then embeds the resulting string.
puts "this number became a string: #{1}"

# We can now see a way to resolve the `TypeError` that we've seen before.
puts "a string" + 2.to_s

# With `p` we can disambiguate that the value is a string and not a number as
# the output may suggest.
p "a string" + 2.to_s

# Behind the scenes, `p` uses the `inspect` method to  transform any object into
# a representation. These two lines are equivalent.
p "this uses `p`"
puts "this uses `inspect`".inspect

#  Another common ambiguous case is `nil`, which is stringified as an empty
#  string. The ambiguity can be entirely silent!
puts "where is my `nil`? #{nil}"
puts "here it is! #{nil.inspect}"

# From here on, we'll use `p` and `inspect` much more often to properly disambiguate.
