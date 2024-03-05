# Classes are fundamental to Ruby. Indeed Ruby is not just an object-oriented language: in Ruby everything is an object, and thus, has a class.

# Here is a class, and it is empty.
class Person
end

# We can create an instance of that class with `new`.
p Person.new

# This was not very useful. Let's put some information in there.
class Person
  attr_accessor "name", "age"
end

# We create a new instance...
bob = Person.new

# ... and we assign the values.
bob.name = "Bob"
bob.age = 20

# Inspecting shows us that the instance variables `@name` and `@age` have been
# assigned.
p bob

# We can retrieve the values individually.
p bob.name
p bob.age

# That was unwieldy: we'd rather set the values directly and immediately
# receive an initialized, consistent instance. Let's do better.

class Person

  # When we do `Person.new`, it will first allocate a new instance
  # then invoke `initialize` on that instance with the arguments it was passed.
  def initialize(name, age)

    # We set `name` and `age` argument values to similarly-named instance
    # variables.
    @name = name
    @age = age
  end
end

alice = Person.new("Alice", 30)
p alice

# Ruby has an "open-class" model. This means that `class Person` did not replace
# the previous class. Instead it reopened the same class for more methods to be
# defined.

# Indeed, the `attr_accessor`s are still there.
p alice.name
alice.age = 25
p alice.age

# Wait... "more methods"? But we used `attr_accessor`, not `def`!

# Remember, in Ruby parentheses are optional, so `name` and `age` are not
# magical ways to access instance variables: they are plain methods.
p alice.name()

# ... nor is assignment, with `name=` and `age=` methods.
alice.age=(42)
p alice.age

# Ruby implements a Smalltalk-like message model: the dot `.` is sending a
# message: the left hand part is the receiver and the right hand part is the
# message name.
# Therefore, in Ruby "attributes" are merely conventional, notably assignment
# is syntactic sugar for invoking the method ending with `=`. `attr_accessor`,
# as well as `attr_reader` and `attr_writer`, merely follow these conventions.

# Let's reopen the class and define methods manually to give them a more
# precise behaviour.
class Person

  # This will redefine a `name` method, overwriting the previous one that
  # `attr_accessor` created.
  def name
    @name
  end

  # Let's improve on the default behaviour and ensure the type is correct.
  def name=(name)
    # We use `raise` instead of `fail`, with a `TypeError` exception.
    raise TypeError unless name.is_a? String

    @name = name
  end

  def age
    @age
  end

  def age=(age)
    # Note the use of `unless` and `is_a?`, making the guard clause read like a
    # sentence.
    raise TypeError unless age.is_a? Integer

    @age = age
  end
end

# We just modified the open `Person` class, which our previous intances were
# using. The changes are immediately available, even to those.

# Let's try for the name...
begin
  alice.name = 30
rescue TypeError => e
  puts e
end

# ... and for the age.
begin
  bob.age = "Bob"
rescue TypeError => e
  puts e
end

# But our initializer is unprotected!
eve = Person.new(30, "eve")
p eve.name
p eve.age

# Let's fix this by using the assignment methods instead.
class Person
  def initialize(name, age)
    name = name
    age = age
  end
end

# Let's try... Hmm, not quite what we expected, what happened?
eve = Person.new(30, "eve")

# As we've seen before, local variables and arguments shadow methods, so `name`
# and `age` on the left hand side of the assignment refer to the arguments,
# thus `@name` and `@age` never get assigned and default to `nil`.
p eve.name
p eve.age

# We need to disambiguate the method from the local variable. For that we need
# to specify the receiver: `self` is the keyword referring to the current
# instance.
class Person
  def initialize(name, age)
    self.name = name
    self.age = age
  end
end

# And now the behaviour is unified.
begin
  eve = Person.new(30, "eve")
rescue TypeError => e
  puts e
end
