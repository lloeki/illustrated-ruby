# In Ruby errors are idiomatically handled via exceptions. Here's a quick overview for handling them.

# Exceptions are typically handled in a `begin` .. `end` construct with a
# `rescue` keyword.
begin
  "1" + 2
rescue
  puts "There was an error!"
end

# Specific errors can be captured instead.
begin
  "1" + 2
rescue TypeError
  puts "There was a TypeError!"
end

# Multiple blocks can be provided, each with its own exception, or no
# exception. Each `rescue` is handled in order.
begin
  "1" + 2
rescue TypeError
  puts "There was a TypeError!"
rescue ArgumentError
  puts "There was an ArgumentError!"
rescue
  puts "There was an uncaught error!"
end

# Here we obtain the exception itself in `e`
begin
  "1" + 2
rescue TypeError => e
  puts "There was a TypeError: #{e}"
rescue => e
  puts "There was an unexpected error: #{e}"
end

# The `else` (called when no exception was rescued) and `ensure` (always
# called) keywords further help refine the control flow.
begin
  "1" + 2
rescue TypeError
  puts "There was a TypeError!"
else
  puts "No errors!"
ensure
  puts "You can always count on me!"
end

# Exceptions can be handled inline, but there is no way to condition the flow
# on exception type. There are also no `ensure` or `else` clauses.
"1" + 2 rescue puts "An error was caught inline!"

# The typeless `rescue` does not capture all exceptions for safety reasons.
# Instead it is equvalent to rescuing `StandardError`, which covers
# non-critical exceptions.
begin
  "1" + 2
rescue StandardError
  puts "There was a `StandardError`!"
end

# The topmost exception type is `Exception`. In most cases it is both
# unnecessary and dangerous to rescue `Exception`.
begin
  "1" + 2
rescue Exception
  puts "There was a critical error and I really don't want to stop!"
end

# You can quickly trigger simple exceptions with a small error message.
begin
  fail "5 is not even!" if 5 % 2 != 0
rescue => e
  puts e
end

# We will come back for a deeper dive into exceptions later.
