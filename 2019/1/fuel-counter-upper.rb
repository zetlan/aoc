#!/usr/bin/env ruby

# Run this with:
# cat 1a.input | xargs ruby fuel-counter-upper.rb

def fuel_needed(mass)
    return (mass / 3) - 2
end

total_fuel = ARGV.map{|mass| fuel_needed(mass.to_i)}.reduce(:+)

print "Part one: Total fuel: #{total_fuel}\n"

really_total_fuel = ARGV.map do |mass|
    module_fuel = 0
    current_fuel_needed = fuel_needed(mass.to_i)
    while current_fuel_needed > 0 do
        module_fuel += current_fuel_needed
        current_fuel_needed = fuel_needed(current_fuel_needed)
    end
    module_fuel
end.reduce(:+)

print "Part two: real total: #{really_total_fuel}\n"