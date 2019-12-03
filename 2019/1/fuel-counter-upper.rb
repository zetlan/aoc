#!/usr/bin/env ruby

# Run this with:
# cat 1a.input | xargs ruby fuel-counter-upper.rb

def fuel_needed(mass)
    return (mass / 3) - 2
end

total_fuel = ARGV.map{|mass| fuel_needed(mass.to_i)}.reduce(:+)

print "Total fuel: #{total_fuel}\n"