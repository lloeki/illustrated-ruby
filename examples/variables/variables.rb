# In Ruby, _variables_ are implicitly declared when assigned and do not carry
# type information.

a = "initial"
p a

# Variables can be reassigned a different type.
a = true
p a

# You can assign multiple variables at once through destructuring assignment of an array.
b, c = ["destructured", "assignment"]
p b, c

# Out-of-bounds variables are `nil`-valued.
d, e, f = ["first", "second, but third will be `nil`"]
p d, e, f

# Destructured values missing variables are silently dropped.
g, h = ["one", "two", "dropped"]
p g, h

# Variables are always references. Mutating the referenced value thus impacts
# all other references.
i = ["foo", "bar"]
p i
j = i
j << "appended"
p i

# Variables referenced before assignment are undefined and raise a `NameError`
begin
  p k
rescue NameError
  puts "`k` was not yet assigned!"
end
k = true

# Variables referenced after a conditional assignment are `nil`-valued.
l = true if l == 2
p l
