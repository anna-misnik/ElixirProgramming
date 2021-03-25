# ElixirProgramming
This project represents an assignment I had to solve during an exam. 

Instructions provided by the examinator: 
You should implement an emulator that execute an assembler program written in a very limited language. 
The processor you should emulate has a state described by: a code segment, a program counter and six registers (0..5). 
There is no memory and the code segment can only be read.

The emulator is initialized with the program counter set to zero (the first instruction) 
and proceed one instruction at a time if the program counter is not set by a branch instruction.

The instructions that the emulator should handle are listed below. 
In the pseudo code, reg[x] to the right means the value in register x. 
To the left in an assignment it means that the value should be stored in register x. 
The output should be collected and returned as a list of values with the first outputted value first.
