# Constants in Ruby are surprising when compared to other languages. Let's walk
# through a few examples to clear it up.

# Here we define a constant. The name must start with a capital.
LIST = [1, 2]
p LIST

# As with variables, constants are references so their value can be mutated.
LIST << 3
p LIST

# To protect from mutation, we can freeze the value. Attempting to mutate the
# value would then raise `FrozenError`.
LIST.freeze

# Constants can be reassigned, although this emits a runtime warning. Freezing,
# being a property of the referenced value, does not protect from reassignment.
LIST = [4, 5]
p LIST

INCREMENT = 1

# Contrary to variables, constants traverse method scopes.
def incr(i)
  i + INCREMENT
end

p incr(5)

