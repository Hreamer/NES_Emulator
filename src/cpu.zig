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

    pub fn decode(self: CPU, opcode: u8) !Instruction {
        //switch over the opcode given and than make an instruction struct
        switch (opcode) {
            //NOOP ( NO OPeration )
            0xEA => {
                return Instruction{
                    .mnemonic = "NOP",
                    .cycles = 2,
                    .opcode = 0xEA,
                    .adressMode = "impl",
                };
            },

            //Stack instructions are implied and therefore are one byte no operands. The stack is always on page one ($100-$1FF) and works top down.
            0x9a => {
                //TXS ( Transfer X to Stack ptr )
                return Instruction{
                    .mnemonic = "TXS",
                    .cycles = 2,
                    .opcode = 0x9a,
                    .adressMode = "impl",
                };
            },
            0xBA => {
                //TSX ( Transfer Stack ptr to X )
                return Instruction{
                    .mnemonic = "TSX",
                    .cycles = 2,
                    .opcode = 0x9a,
                    .adressMode = "impl",
                };
            },
            0x48 => {
                //PHA ( PusH Accumulator )
                return Instruction{
                    .mnemonic = "PHA",
                    .cycles = 3,
                    .opcode = 0x9a,
                    .adressMode = "impl",
                };
            },
            0x68 => {
                //PLA ( PuLl Accumulator )
                return Instruction{
                    .mnemonic = "PLA",
                    .cycles = 4,
                    .opcode = 0x9a,
                    .adressMode = "impl",
                };
            },
            0x08 => {
                //PHP ( PusH Processor status )
                return Instruction{
                    .mnemonic = "PHP",
                    .cycles = 3,
                    .opcode = 0x9a,
                    .adressMode = "impl",
                };
            },
            0x28 => {
                //PLP ( PuLl Processor Status )
                return Instruction{
                    .mnemonic = "PLP",
                    .cycles = 4,
                    .opcode = 0x9a,
                    .adressMode = "impl",
                };
            },

            //Register Instructions

            //ROL ( ROtate Left )

            //ROR ( ROtate Right )

            //RTI ( ReTurn from Interrupt )

            //RTS ( ReTurn from Subroutine )
            0x60 => {
                return Instruction{
                    .mnemonic = "RTS",
                    .cycles = 6,
                    .opcode = 0x60,
                    .adressMode = "impl",
                };
            },

            //SBC ( SuBtract with Carry )

            //STA ( STore Accumulator )
            0x85 => {
                return Instruction{
                    .mnemonic = "STA",
                    .cycles = 3,
                    .opcode = 0x85,
                    .adressMode = "ZP",
                    .operand1 = memory.getByte(self.PC + 1),
                };
            },
            0x95 => {
                return Instruction{
                    .mnemonic = "STA",
                    .cycles = 4,
                    .opcode = 0x95,
                    .adressMode = "ZPX",
                    .operand1 = memory.getByte(self.PC + 1),
                };
            },
            0x8D => {
                return Instruction{
                    .mnemonic = "STA",
                    .cycles = 4,
                    .opcode = 0x8D,
                    .adressMode = "abs",
                    .operand1 = memory.getByte(self.PC + 1),
                    .operand2 = memory.getByte(self.PC + 2),
                };
            },
            0x9D => {
                return Instruction{
                    .mnemonic = "STA",
                    .cycles = 5,
                    .opcode = 0x9D,
                    .adressMode = "absX",
                    .operand1 = memory.getByte(self.PC + 1),
                    .operand2 = memory.getByte(self.PC + 2),
                };
            },
            0x99 => {
                return Instruction{
                    .mnemonic = "STA",
                    .cycles = 5,
                    .opcode = 0x99,
                    .adressMode = "absY",
                    .operand1 = memory.getByte(self.PC + 1),
                    .operand2 = memory.getByte(self.PC + 2),
                };
            },
            0x81 => {
                return Instruction{
                    .mnemonic = "STA",
                    .cycles = 6,
                    .opcode = 0x81,
                    .adressMode = "indrX",
                    .operand1 = memory.getByte(self.PC + 1),
                };
            },
            0x91 => {
                return Instruction{
                    .mnemonic = "STA",
                    .cycles = 6,
                    .opcode = 0x91,
                    .adressMode = "indrY",
                    .operand1 = memory.getByte(self.PC + 1),
                };
            },

            //STX ( STore X register )
            0x86 => {
                return Instruction{
                    .mnemonic = "STX",
                    .cycles = 3,
                    .opcode = 0x86,
                    .adressMode = "ZP",
                    .operand1 = memory.getByte(self.PC + 1),
                };
            },
            0x96 => {
                return Instruction{
                    .mnemonic = "STX",
                    .cycles = 4,
                    .opcode = 0x96,
                    .adressMode = "ZPY",
                    .operand1 = memory.getByte(self.PC + 1),
                };
            },
            0x8E => {
                return Instruction{
                    .mnemonic = "STX",
                    .cycles = 4,
                    .opcode = 0x8E,
                    .adressMode = "abs",
                    .operand1 = memory.getByte(self.PC + 1),
                    .operand2 = memory.getByte(self.PC + 2),
                };
            },

            //STY ( STore Y register )
            0x84 => {
                return Instruction{
                    .mnemonic = "STY",
                    .cycles = 3,
                    .opcode = 0x84,
                    .adressMode = "ZP",
                    .operand1 = memory.getByte(self.PC + 1),
                };
            },
            0x94 => {
                return Instruction{
                    .mnemonic = "STY",
                    .cycles = 4,
                    .opcode = 0x94,
                    .adressMode = "ZPX",
                    .operand1 = memory.getByte(self.PC + 1),
                };
            },
            0x8C => {
                return Instruction{
                    .mnemonic = "STY",
                    .cycles = 4,
                    .opcode = 0x8C,
                    .adressMode = "abs",
                    .operand1 = memory.getByte(self.PC + 1),
                    .operand2 = memory.getByte(self.PC + 2),
                };
            },

            //ORA ( bitwise OR with Accumulator )

            //LSR ( Logical Shift Right )

            //LDY ( LoaD Y register )

            //LDX ( LoaD X register )

            //LDA ( LoaD Accumulator )

            //JSR ( Jump to SubRoutine )
            0x20 => {
                return Instruction{
                    .mnemonic = "JSR",
                    .cycles = 6,
                    .opcode = 0x20,
                    .adressMode = "abs",
                    .operand1 = memory.getByte(self.PC + 1),
                    .operand2 = memory.getByte(self.PC + 2),
                };
            },

            //JMP ( JuMP )
            0x4C => {
                //There is some overhead that needs to be checked for here
                //Indirect jumps do not cross page boundries so if operand2 is 0xFF than we need to take the high bite from operand1+0x00 and low bite from operand1+operand2
                return Instruction{
                    .mnemonic = "JMP",
                    .cycles = 3,
                    .opcode = 0x4C,
                    .adressMode = "indr",
                    .operand1 = memory.getByte(self.PC + 1),
                    .operand2 = memory.getByte(self.PC + 2),
                };
            },
            0x6C => {
                //There is some overhead that needs to be checked for here
                //Indirect jumps do not cross page boundries so if operand2 is 0xFF than we need to take the high bite from operand1+0x00 and low bite from operand1+operand2
                return Instruction{
                    .mnemonic = "JMP",
                    .cycles = 5,
                    .opcode = 0x6C,
                    .adressMode = "indr",
                    .operand1 = memory.getByte(self.PC + 1),
                    .operand2 = memory.getByte(self.PC + 2),
                };
            },

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
    adressMode: [*]u8,

    operand1: u8 = void,
    operand2: u8 = void,
};

//Enum declarations
const instrType = enum {
    comeBackToThis,
    comeBackToThis2,
};
