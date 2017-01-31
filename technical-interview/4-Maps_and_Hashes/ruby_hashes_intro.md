In Ruby, the map concept appears as a built-in data type called a Hash. A hash contains key-value pairs. Hashes might soon become your favorite data structure in Ruby—they're extremely easy to use and useful. Here's a sample of setting up a Hash

```ruby
udacity = {}
udacity['u'] = 1
udacity['d'] = 2
udacity['a'] = 3
udacity['c'] = 4
udacity['i'] = 5
udacity['t'] = 6
udacity['y'] = 7

p udacity
# => {'u'=> 1, 'd'=> 2, 'a'=> 3, 'c'=> 4, 'i'=> 5, 't'=> 6, 'y'=> 7}
```

In this case, the letters in "udacity" were each keys in our hash, and the position of that letter in the string was the value. Thus, I can do the following:

```ruby
p udacity['t']
# => 6
```

This statement is saying "go to the key labeled 't' and find it's value, 6".

Hashes are wonderfully flexible—you can store a wide variety of structures as values. You store another hash or a list:

```ruby
hashes = {}
hashes['h'] = [1]
hashes['a'] = [2]
hashes['s'] = [3]
hashes['h'].append(4)
hashes['e'] = [5]
hashes['s'].append(6)
print hashes
# => {'h'=> [1, 4], 'a'=> [2], 's'=> [3, 6], 'e'=> [5]}
```

You can learn even more about hashes in the [Ruby documentation](https://ruby-doc.org/core-2.2.3/Hash.html).
