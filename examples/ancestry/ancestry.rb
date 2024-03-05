# Did I mention classes were fundamental to Ruby? Well, that was an
# understatement, they are so pervasive that the object model is critical to
# understanding Ruby.

class Pet
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def pet
    puts "#{@name} likes that!"
  end
end

class Dog < Pet
end

class Cat < Pet
  def pet
    purr
  end

  private

  def purr
    puts "#{@name} purrs!"
  end
end

# Let's create a couple of instances
butler = Dog.new("Butler")
spot = Cat.new("Spot")

# The receiver is in `spot`, which is of class `Cat`.
p spot.class

# The message is `pet`, which `Cat` defines.
p spot.class.instance_methods(false)

# So this will invoke the `pet` method from `Cat`.
spot.pet

# Indeed `spot` responds to the message `pet`.
p spot.respond_to? :pet

# The receiver is `butler`, which is of class `Dog`.
p butler.class

# The message is `pet`, which `Dog` does not define.
p Dog.instance_methods(false)

# so Ruby walks up the ancestry chain.
p Dog.ancestors
#
# The next one is `Pet`, so this will invoke the `pet` method from `Pet`.
butler.pet

# And so the `butler` instance does too respond to the message `pet`.
p butler.respond_to? :pet

# We can see that the methods are not the same.
p spot.method(:pet) == butler.method(:pet)

# When Ruby does not find a method corresponding to the message, it raises
# `NoMethodError`.
begin
  spot.jump
rescue NoMethodError => e
  puts e
end

# When Ruby find a method corresponding to the message, but its visibility is
# incompatible, it also raises `NoMethodError` but the message is different.
begin
  spot.purr
rescue NoMethodError => e
  puts e
end

# Using the `send` method, we can send the `purr` message directly to `spot`.
spot.send :purr

# This message-oriented approach is what makes Ruby so dynamic. Everything is an object in Ruby, and thus everything has methods. Even classes!

# In fact, a class is an instance of the class `Class`.
puts "`Pet` is a #{Pet.class}"

# And `Class` itself is an instance of the class `Class`.
puts "`Class` is a #{Class.class}"

# And so, it is only natural that we can instantiate classes as well.
snake = Class.new(Pet) do
  def pet
    puts "#{@name} slithers"
  end
end

# `new` is a method whose receiver is an instance of the class Class.
loki = snake.new "Loki"

# And, `snake` inheriting from `Pet`, it properly responded to the `initialize`
# message.
loki.pet

# So `new` is an instance method on an instance of the class `Class`, which
# means... it is a class method?

# Let's try to define another class method by reopening the class `Class`.
class Class
  def hello
    puts "hello, I am #{name}"
  end
end

# It worked!
Pet.hello

# But maybe a bit too much... the change is effective for *every* instance of
# the class `Class`, which is... everything!
String.hello

# We want class methods that exist only for a specific class, but it can't be
# defined on the class itelf or it'll apply to instances of that class, and it
# can't be defined on the class of that class either, as this is `Class`, as we
# have just seen.

begin

  # We would need a new "metaclass" that exists just for that `Pet` class...
  pet_metaclass = Class.new(Class) do
    def meta_hello
      puts "hello meta"
    end
  end

  # ... that we'd instantiate to give us a class to inherit from.
  pet_class = Class.new(pet_metaclass.new) do
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  pet_class.meta_hello

# Unfortunately Ruby does not allow us to do that!
rescue TypeError => e
  puts e
end

# Fortunately Ruby has that answered already. Since that class would exist only
# once for each class, it is a singleton. Therefore the name is the "singleton
# class", and Ruby creates one for every instance of a class.
p Pet.singleton_class

# The class is reachable using `<<`, which moves the receiver to the singleton
# class of the object passed.
class << Pet
  def hello
    puts "singleton!"
  end
end

# And this time, it works!
Pet.hello

# The `class` keyword changes the receiver to be the class being defined, and
# the receiver is always accessible with `self`.
class Dog
  # The receiver is accessible via `self`, so we can pass that to `<<`.
  class << self
    def bark
      puts "woofleton!"
    end
  end

  # A shorthand exists with `def` outside of `class << self`.
  def self.lick
    puts "lickleton!"
  end
end

Dog.bark
Dog.lick

# These are still instance methods, it just so happens that they are instance
# methods of the singleton class for `Dog`, of which the `Dog` class is an
# instance of.
p Dog.singleton_class.instance_methods(false)

# This is visible in the ancestry chain.
p Dog.singleton_class.ancestors.first

# Every instance gets singleton classes, not just instances of the class
# `Class`. Here's one for an instance of `Cat`.
p spot.singleton_class

# We can access the singleton class of that instance the same way.
class << spot
  # And define methods for *just* that cat and *no other* cat.
  def jump
    puts "#{@name} jumps!"
  end
end

spot.jump
