=begin
Write a HashTable class that stores strings
in a hash table, where keys are calculated
using the first two letters of the string.
=end
class HashTable
  def initialize
    @table = [nil]*10000
  end

  # Input a string that's stored in the table.
  def store(string)
  end

  # Return the hash value if the  string is already in the table.
  # Return -1 otherwise.
  def lookup(string)
    return -1
  end

  # Helper function to calulate a hash value from a string.
  def calculate_hash_value(string)
    return -1
  end
end

# Setup
hash_table = HashTable.new

# Test calculate_hash_value
# Should be 8568
p hash_table.calculate_hash_value('UDACITY')

# Test lookup edge case
# Should be -1
p hash_table.lookup('UDACITY')

# Test store
hash_table.store('UDACITY')
# Should be 8568
p hash_table.lookup('UDACITY')

# Test store edge case
hash_table.store('UDACIOUS')
# Should be 8568
p hash_table.lookup('UDACIOUS')
