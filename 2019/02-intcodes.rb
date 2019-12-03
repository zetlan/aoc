#!/bin/env ruby

def operate(code, arg1, arg2)
    case code
    when 99 then
        print "Program halt.\n"
        exit 0
    when 1 then
        return arg1 + arg2
    when 2 then
        return arg1 * arg2
    else
        raise Exception "opcode #{code} not recognized"
    end
end

def load_file(filename)
    file = File.open(filename, "r")
    values = []
    file.each_line do |line| 
        line.split(",").map {|element| values.append(element.to_i)} 
    end
    return values
end

def run_program(program)
    position = 0
    operations = 0
    max_operations = 1_000_000

    while operations < max_operations do
        opcode = program[position]
        if opcode == 99 then
            print "Program halt.\n"
            exit 0
        end    
        arg1_position = program[position + 1]
        arg2_position = program[position + 2]
        output_position = program[position + 3]

        new_result = operate(opcode, program[arg1_position], program[arg2_position])
        program[output_position] = new_result
        position += 4
        operations += 1
    end
    return program
end

input_file = ARGV[0]

program = load_file(input_file)

begin
    run_program(program)
rescue SystemExit => system_exit
    output = File.open(input_file + ".out", "w")
    output.write(program.map{|i| i.to_s}.join(","))
    output.close
    print "Corrected position 0: #{program[0]}\n"
end


