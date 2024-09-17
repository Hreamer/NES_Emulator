const std = @import("std");
const Memory = @import("memory.zig");

const memory = Memory.Memory();

const CPU = struct {
    PC: u16,
    SP: u8,
    Status: u8, //read the docs for this each bit matters
    Accumulator: u8,
    X: u8,
    Y: u8,

    pub fn executeInstr(self: CPU) !void {
        //remember that we need to check for interrupts every step which includes before the next instruction is run

        const instruction = memory.getByte(self.PC);

        //if there was no error than we handle the returned instruction otherwise propagate the error upward
        if (instruction) |instr| {
            //time to start disecting the command
            _ = instr; //del later
        } else |err| {
            return err;
        }

        return void;
    }

    pub fn decode(opcode: u8) !Instruction {
        //switch over the opcode given and than make an instruction struct
        switch (opcode) {
            //NOOP ( NO OPeration )

            //Stack instructions are implied and therefore are one byte no operands. The stack is always on page one ($100-$1FF) and works top down.
            0x9a => {
                return Instruction{
                    .mnemonic = "TXS",
                    .cycles = 2,
                    .opcode = 0x9a,
                };
            },
            0xBA => {
                return Instruction{
                    .mnemonic = "TSX",
                    .cycles = 2,
                    .opcode = 0x9a,
                };
            },
            0x48 => {
                return Instruction{
                    .mnemonic = "PHA",
                    .cycles = 3,
                    .opcode = 0x9a,
                };
            },
            0x68 => {
                return Instruction{
                    .mnemonic = "PLA",
                    .cycles = 4,
                    .opcode = 0x9a,
                };
            },
            0x08 => {
                return Instruction{
                    .mnemonic = "PHP",
                    .cycles = 3,
                    .opcode = 0x9a,
                };
            },
            0x28 => {
                return Instruction{
                    .mnemonic = "PLP",
                    .cycles = 4,
                    .opcode = 0x9a,
                };
            },

            //Register Instructions

            //ROL ( ROtate Left )

            //ROR ( ROtate Right )

            //RTI ( ReTurn from Interrupt )

            //RTS ( ReTurn from Subroutine )

            //SBC ( SuBtract with Carry )

            //STA ( STore Accumulator )

            //STX ( STore X register )

            //STY ( STore Y register )

            //ORA ( bitwise OR with Accumulator )

            //LSR ( Logical Shift Right )

            //LDY ( LoaD Y register )

            //LDX ( LoaD X register )

            //LDA ( LoaD Accumulator )

            //JSR ( Jump to SubRoutine )

            //JMP ( JuMP )

            //INC ( INCrement memory )

            //EOR ( bitwise Exclusive OR )

            //DEC ( DECrement memory )

            //CPY ( ComPare Y register )

            //CPX ( ComPare X register )

            //CMP ( CoMPare accumulator )

            //BRK ( BReaK )

            //Branch Instructions

            //BIT ( test BITs )

            //ASL ( Arithmetic Shift Left )

            //AND ( bitwise AND with accumulator )

            //ADC ( ADd with Carry )

            //Yeah shit is wrong if we dont recognize the opcode lol
            else => {
                return anyerror;
            },
        }
    }
};

const Instruction = struct {
    mnemonic: [*]u8,
    cycles: u8,
    opcode: u8,

    operand1: u8 = void,
    operand2: u8 = void,
};

//Enum declarations
const instrType = enum {
    comeBackToThis,
    comeBackToThis2,
};
