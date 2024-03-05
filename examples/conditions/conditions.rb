# Branching with Ruby is straightforward, but comes with a few twists.

# Here's a basic example.
if 7 % 2 == 0
  puts "7 is even"
else
  puts "7 is odd"
end

# You can have an `if` statement without an `else`.
if 8 % 4 == 0
  puts "8 is divisible by 4"
end

# Logical operators like `&&` and `||` are often useful in conditions.
if 8 % 2 || 7 % 2 == 0
  puts "either 8 or 7 are even"
end

# You can chain conditions with `elsif`
if 9 < 0
  puts "9 is negative"
elsif 9 < 10
  puts "9 has 1 digit"
else
  puts "9 has multiple digits"
end

# Instead of using negation, we can use `unless`, which is a shorthand for `if !`. This can simplify conditions in some cases.
unless 42 < 0
  puts "42 is a natural number"
end

# Note that while `unless` also accepts an `else` clause it is not recommended
# because of the double-negative thinking it induces.

# `if` and `unless` can also be put at the end, and do not accept an `else` clause.
puts "5 is even" if     5 % 2 == 0
puts "5 is odd"  unless 5 % 2 == 0

# The ternary operator can be used for inline conditions.
puts "5 is " + (5 % 2 == 0 ? "even" : "odd")

# `and` and `or` can be used as shortcuts for `if` and `else` clauses. Note
# that these are intended for control flow with low precedence, not as logical
# operators.
8 % 2 == 0 || 7 % 2 == 0 and puts "either 8 or 7 are even"
9 < 0 || 9 >= 10 or puts "9 has 1 digit"

# Note that you don't need parentheses around conditions in Ruby.
