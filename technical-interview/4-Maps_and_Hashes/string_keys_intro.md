In this quiz, you'll write your own hash table and hash function that uses string keys. Your table will store strings in buckets by their first two letters, according to the formula below:

```
Hash Value = (ASCII Value of First Letter * 100) + ASCII Value of Second Letter
```

You can assume that the string will have at least two letters, and the first two characters are uppercase letters (ASCII values from 65 to 90). You can use the Python function `ord()` to get the ASCII value of a letter, and `chr()` to get the letter associated with an ASCII value.

You'll create a HashTable class, methods to store and lookup values, and a helper function to calculate a hash value given a string. You cannot use a Python dictionary—only lists! And remember to store lists at each bucket, and not just the string itself. For example, you can store "UDACITY" at index 8568 as `["UDACITY"]`.
