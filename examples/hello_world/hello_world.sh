# To run the program, put the code in `hello-world.rb` and use `ruby`.
$ ruby hello_world.rb
hello world

# Sometimes we'll want to run our program directly, like a binary would. We can
# do this using a shebang.
$ echo '#!/usr/bin/env ruby' > hello_world
$ chmod +x hello_world
$ cat hello_world.rb >> hello_world
$ ls
hello_world	hello_world.rb

# We can then execute the program directly.
$ ./hello_world
hello world

# Now that we can run basic Ruby programs, let's learn more about the language.
