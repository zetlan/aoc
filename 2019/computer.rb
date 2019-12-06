#!/bin/env ruby

module Aoc
    class Computer
        attr_accessor :program

        @program = []
        def initialize(program = [])
            @program = program
        end

        def self.from_file(filename)
            file = File.open(filename, "r")
            values = []
            file.each_line do |line| 
                line.split(",").map {|element| values.append(element.to_i)} 
            end
            return Computer.new(values)
        end

        def run
            return nil if @program.empty?
            position = 0
            operations = 0
            max_operations = 1_000_000
        
            while operations < max_operations do
                opcode = @program[position]
                if opcode == 99 then
                    return self
                end    
                arg1_position = @program[position + 1]
                arg2_position = @program[position + 2]
                output_position = @program[position + 3]
        
                new_result = operate(opcode, @program[arg1_position], @program[arg2_position])
                @program[output_position] = new_result
                position += 4
                operations += 1
            end
            if operations >= max_operations
                raise Exception "Max operations #{max_operations} reached"
            end
            return self
        end

        def result
            return @program.empty? ? nil : @program[0]
        end

        private
        def operate(code, arg1, arg2)
            case code
            when 99 then
                return nil
            when 1 then
                return arg1 + arg2
            when 2 then
                return arg1 * arg2
            else
                raise Exception "opcode #{code} not recognized"
            end
        end
    end
end

def test
    test_programs = [
        {
            'result': 3500,
            'program': [1,9,10,3,2,3,11,0,99,30,40,50]
        },
        {
            'result': 30,
            'program': [1,1,1,4,99,5,6,0,99]
        }
    ]

    test_programs.each do |tester|

        computer = Aoc::Computer.new(tester[:program]).run

        result = computer.result
        if (result == tester[:result]) then
            print "Pass\n"
        else
            raise Exception "Test failure: expected #{tester[:result]}, was actually #{result}"
        end
    end

    computer = Aoc::Computer.new
    if (computer.run.nil?) then 
        print "Pass\n" # previous line would be an exception if it didn't pass
    else
        raise Exception "Expected nil result"
    end
end

# test
