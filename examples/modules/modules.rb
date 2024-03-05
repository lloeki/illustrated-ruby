# Modules are the Ruby way to organise code.

# Here's a module with a method.
module MyModule
  def plus(a, b)
    a + b
  end
end

# By using `extend`, we can inject the method in the current context.
extend MyModule
p plus(1, 2)

# Constants can be obtained dynamically.
Object.const_get :INCREMENT

# It is a `SyntaxError` to set a constant dynamically inside a method, but it is possible with `const_set`.
def decr(i)
  Object.const_set :DECREMENT, 1

  i - DECREMENT
end

p decr(5)

# The constant is global. This would raise `NameError` if `decr` hadn't been called.
p DECREMENT
