# Symbols are a unique feature of Ruby. They may look like strings but are not!

# Here's a symbol. It starts with a colon.
p :symbol

# Strings and symbols are not identical, even if their content look the same.
p :symbol == "symbol"

# We can convert a symbol to a string, and back.
p :symbol.to_s
p 'string'.to_sym

# The contents of these two strings are equal, but they are not the same object.
p "string".object_id == "string".object_id

# Contrary to strings, each symbol exists only once.
p :symbol.object_id == :symbol.object_id

# To write more complex symbols, quotes can be used.
p :'a single-quoted symbol'

# Quoting rules are the same as for strings, e.g interpolation is supported.
p :"a double-quoted symbol #{2}"

# We can use `%s` to write symbols, as an equivalent to single-quoting. AS for
# strings, the delimiter can be changed. There's no `%S` though.
p %s(this symbol has spaces)
