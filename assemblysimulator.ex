defmodule Basics do

  'PROBLEM I STORTS SETT: Implementera en emulator som kan exekvera ett assemblerprogram.
  1. Den processor har ett tillstånd:
    - ett kodsegment,
    - en programräknare,
    - sex register (0..5).
    OBS! Det finns inget minne och kodsegmentet kan bara läsas.

  2. Värden som blir (output) skall returneras i en lista ordnad med det första ut-värdet först'
  #koden är skapad av Anna Misnik, 19.03.2021 Programmering 2

 #representing immidiate values and registers
 #a register is represented as it's value and number
 @type register() :: {:register, number(), number()}
 @type value() :: {:num, number()}

 #functions
 @type expr() :: {:add, value(), value(), value()}
               | {:addi, value(), value(), value()}
               | {:beq, value(), value(), value()}
               | {:out, value()}
               | {:halt}

  def test() do
    b = [{:addi,  1,  0, 10},
    {:addi,  3,  0,  1},
    {:out,   3},
    {:addi,  1,  1, -1},
    {:addi,  4,  3,  0},
    {:add,   3,  2,  3},
    {:out,   3},
    {:beq,   1,  0,  3},
    {:addi,  2,  4,  0},
    {:beq,   0,  0, -6},
    {:halt}]
    c = assembel_start(b, [], 0, [], b)
    c
  end

#cstart with creating stack and setting programcounter to 0
def assembel_start([head|tail], stack, count, output, seq) do
  if count != 0 do
    assembel_start(tail, stack, count - 1, output, seq)
  else
    assembel(seq, stack, count, output, seq)
  end
 end

 def assembel([{:halt}|[]], _, _, output, _) do
   output
 end
# ADD
def assembel([{:add, destin, source, 0}|rest], stack, count, output, seq) do
  IO.puts("add")
  assembel(rest, [{:register, destin, getelement(source, stack)}|stack], count + 1, output, seq)
end
def assembel([{:add, destin, 0, source}| rest], stack, count, output, seq) do
  IO.puts("add")
  assembel(rest, [{:register, destin, getelement(source, stack)}|stack], count + 1, output, seq)
end
def assembel([{:add, destin, s1, s2}| rest], stack, count, output, seq) do
  IO.puts("add")
  assembel(rest, [{:register, destin, getelement(s1, stack) + getelement(s2, stack)}|stack], count + 1, output, seq)
end

 # ADDI instr, sum two values and put into dest register
def assembel([{:addi, destin, 0, value}|rest], stack, count, output, seq) do
  IO.puts("add")
  assembel(rest, [{:register, destin, value}|stack], count+1, output, seq)
end
def assembel([{:addi, destin, source, imm}| rest], stack, count, output, seq) do
  assembel(rest, [{:register, destin, getelement(source, stack) + imm}|stack], count + 1, output, seq)
end

def assembel([{:beq, v1, v2, offset}|rest], stack, count, output, seq) do
  IO.puts("beq")
  IO.puts(getelement(v1, stack))
  IO.puts(getelement(v2, stack))
  if getelement(v1, stack) == getelement(v2, stack) do
    assembel(goback(seq, count + offset, 0), stack,count + offset, output, seq)
  else
    assembel(rest, stack, count + 1, output, seq)
  end
 end

def assembel([{:out, s1}| rest], stack, count, output, seq) do
  IO.puts("out")
  assembel(rest, stack, count+1, output ++ [getelement(s1, stack)], seq)
end

#func to go back to the correct instruction after a beq
def goback([head|tail], target, current) do
  IO.puts("goback")
  if current != target do
    goback(tail, target, current + 1)
  else
    [head|tail]
  end
 end

#func to find the value stored in the register
def getelement(_, []) do 0 end
def getelement(source, [{:register, nr, value}|tail]) do
  if source != nr do
      getelement(source, tail)
  else
    value
  end
end
end
