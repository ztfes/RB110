# Practice Problem 1

## Turn this array into a hash where the names are the keys and the values are the positions in the array.

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flinstones_hash = {}

flintstones.each_with_index do |name, index|
  flinstones_hash[name] = index
end

puts flinstones_hash

# Practice Problem 2

## Add up all of the ages from the Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

puts ages.values.sum

# Practice Problem 3

## remove people with age 100 and greater.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

puts ages.select! {|key, value| value < 100}

# Practice Problem 4

## Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

puts ages.values.min

# Practice Problem 5

## Find the index of the first name that starts with "Be"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.each_with_index do |name, index|
  puts index if name[0..1] == 'Be'
end

# Practice Problem 6

## Write code that changes the array below so that all of the names are shortened to just the first three characters. Do not create a new array.

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
puts flintstones.map! {|name| name[0..2]}

# Practice Problem 7

## Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

char_frequency = {}

statement.chars.each do |char|
  char_frequency[char] = statement.chars.count(char)
end

puts char_frequency

# Practice Problem 8

=begin 

Q***What happens when we modify an array while we are iterating over it? What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end


A***This code would iterate over each element in array object 'number'. With each iteration, the array is modified by removing the proceeding element. This results in iterating over elements 0 and 2 and printing integers 1 and 3 to the screen. 


Q***What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end


A***The each method is called on the numbers array and passed a do..end block as an argument. With each iteration, the current element is printed to the screen. The pop method is called on the numbers array with integer 1 passed as an argument. This will remove and return the last element of the array. This array modification will have side effects on iteration in that with each iteration, the array is 1 element shorter. This code will iterate over the numbers array twice with indices 0 and 1. Integers 1 and 2 will be print to the screen.

=end

# Practice Problem 9

# Write your own version of the rails titleize implementation.

words = "the flintstones rock"

# Split string into array of individual words, call capitalize method on each element in array, join the array into string

puts words.split.each {|word| word.capitalize!}.join(' ')

# Practice Problem 10

=begin

Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior). Your solution should produce the hash below

=end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, characteristics|
  if characteristics["age"] <= 17
    characteristics["age_group"] = 'kid'
  elsif characteristics["age"] >= 18 && characteristics["age"] <= 64
    characteristics["age_group"] = 'adult'
  elsif characteristics["age"] > 64
    characteristics["age_group"] = 'senior'
  end
end

puts munsters
