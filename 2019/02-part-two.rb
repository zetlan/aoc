require_relative './computer.rb'

input_filename = ARGV[0]

computer = Aoc::Computer.from_file(input_filename)

initial_program = computer.program.clone

target_value = 19690720

def find_target(target_value, initial_program)
    for noun in 0..99 do
        print "noun: #{noun}\n"
        for verb in 0..99 do
            # print "\tverb: #{verb};"
            current_program = initial_program.dup
            # [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,19,5,23,2,6,23,27,1,6,27,31,2,31,9,35,1,35,6,39,1,10,39,43,2,9,43,47,1,5,47,51,2,51,6,55,1,5,55,59,2,13,59,63,1,63,5,67,2,67,13,71,1,71,9,75,1,75,6,79,2,79,6,83,1,83,5,87,2,87,9,91,2,9,91,95,1,5,95,99,2,99,13,103,1,103,5,107,1,2,107,111,1,111,5,0,99,2,14,0,0]
            #
            current_program[1] = noun
            current_program[2] = verb
            computer = Aoc::Computer.new(current_program)
            result = computer.run.result
            print " result: #{result}\n"
            if (result == target_value) then
                print "Noun/verb: #{noun}/#{verb} - #{100 * noun + verb}\n"
                return result
            end
        end
    end
end

result = find_target(target_value, initial_program)
print "Target result not reached\n" if result != target_value
