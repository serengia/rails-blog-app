name = %w[James John Jill]

if name.empty?
  puts 'Hello, Stranger'
else
  #   name.each do |name|
  #     puts "Hello, #{name}"
  #   end
  name.each { |name| puts "Hello, #{name}" }
end

random_nums = (1..100).to_a.shuffle
# p random_nums
random_nums.select { |num| num if num.even? }
# p odd_rand_nums

('A'..'z').to_a
# p alphabet
# p quick_arr

# HASHES
{ name: 'James', age: 27, location: 'Chicago' }
# p samp_hash[:name]
# p samp_hash.keys
# p samp_hash.values

# samp_hash.each do |key, value|
#     puts "The value for key is #{key} and the value is #{value}"
#     end

# samp_hash.each{|key, value| samp_hash.delete(key) if value.is_a?(String)}
# p samp_hash
