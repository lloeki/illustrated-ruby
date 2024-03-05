# Methods are central in Ruby. We'll learn about methods with a few different
# examples.

# Here's a method that takes two `Integer`s and returns their sum as an
# `Integer`. In Ruby the return value of a method is the value of its last
# expression.
def plus(a, b)
  a + b
end

# A method can be redefined. The previous method is replaced. Here we make
# arguments optional by providing default values.
def plus(a = 0, b = 0)
  a + b
end

# Call a method as you'd expect, with `name(args)`.
res = plus(1, 2)
p res
res = plus()
p res

# In Ruby, parentheses can be omitted.
res = plus 1, 2
p res
res = plus
p res

# Thanks to the arguments, Ruby can disambiguate between a variable and a method call.
plus = '+'
res = plus 4, 5
p res

# When there's no argument to a method, Ruby resolves to the local
# variable.
res = plus
p res

# Disambiguation can be achieved by using parentheses.
res = plus()
p res

# There is no type attached to variables: as long as the arguments can be added with `+` the method works.
res = plus "2", "3"
p res

# Methods don't close over outside references.
def print_res
  puts res
end

begin
  print_res
rescue NameError => e
  puts e
end

# Method names can end with a question mark. By convention these return
# booleans, are called "predicates", and a `is_` or `has_` prefix is omitted.
def even?(i)
  i % 2 == 0
end
p even?(4)

# Method names can end with an exclamation mark. By convention this is done to
# to draw attention, evoking "danger", especially in contrast with a non-suffixed
# method of the same name.

# This can mean the method performs a mutation.
def plus!(str, tail)
  str << tail
end

# The "danger" is to unsuspectedly mutate when calling the method.
s = "hello"
plus!(s, " world")
p s

# This can mean the method raises an exception.
def plus!(a, b)
  fail "no odds!" if odd?(a) || odd?(b)
  a + b
end

# The "danger" is to have the uncaught exception crash the runtime.
begin
  plus!(1, 2)
rescue => e
  puts e
end
