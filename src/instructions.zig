const processor = @import("cpu.zig");
const Memory = @import("memory.zig");

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

pub fn decode(cpu: processor.CPU, opcode: u8) !Instruction {
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

        //Register Instructions: All Immediate adressing, 2 cycles, different mnemonic
        0xAA => {
            return Instruction{
                .mnemonic = "TAX", //Transfer A to X
                .cycles = 2,
                .opcode = 0xAA,
                .adressMode = "impl",
            };
        },
        0x8A => {
            return Instruction{
                .mnemonic = "TXA", //Transfer X to A
                .cycles = 2,
                .opcode = 0x8A,
                .adressMode = "impl",
            };
        },
        0xCA => {
            return Instruction{
                .mnemonic = "DEX", //DEcrement X
                .cycles = 2,
                .opcode = 0xCA,
                .adressMode = "impl",
            };
        },
        0xE8 => {
            return Instruction{
                .mnemonic = "INX", //INcrement X
                .cycles = 2,
                .opcode = 0xE8,
                .adressMode = "impl",
            };
        },
        0xA8 => {
            return Instruction{
                .mnemonic = "TAY", //Transfer A to Y
                .cycles = 2,
                .opcode = 0xA8,
                .adressMode = "impl",
            };
        },
        0x98 => {
            return Instruction{
                .mnemonic = "TYA", //Transfer Y to A
                .cycles = 2,
                .opcode = 0x98,
                .adressMode = "impl",
            };
        },
        0x88 => {
            return Instruction{
                .mnemonic = "DEY", //DEcrement Y
                .cycles = 2,
                .opcode = 0x88,
                .adressMode = "impl",
            };
        },
        0xC8 => {
            return Instruction{
                .mnemonic = "INY", //INcrement Y
                .cycles = 2,
                .opcode = 0xC8,
                .adressMode = "impl",
            };
        },

        //ROL ( ROtate Left )
        0x2A => {
            return Instruction{
                .mnemonic = "ROL", //INcrement Y
                .cycles = 2,
                .opcode = 0x2A,
                .adressMode = "accum",
            };
        },
        0x26 => {
            return Instruction{
                .mnemonic = "ROL", //INcrement Y
                .cycles = 5,
                .opcode = 0x26,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x36 => {
            return Instruction{
                .mnemonic = "ROL", //INcrement Y
                .cycles = 6,
                .opcode = 0x36,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x2E => {
            return Instruction{
                .mnemonic = "ROL", //INcrement Y
                .cycles = 6,
                .opcode = 0x2E,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x3E => {
            return Instruction{
                .mnemonic = "ROL", //INcrement Y
                .cycles = 7,
                .opcode = 0x3E,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //ROR ( ROtate Right )
        0x6A => {
            return Instruction{
                .mnemonic = "ROR", //INcrement Y
                .cycles = 2,
                .opcode = 0x6A,
                .adressMode = "accum",
            };
        },
        0x66 => {
            return Instruction{
                .mnemonic = "ROR", //INcrement Y
                .cycles = 5,
                .opcode = 0x66,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x76 => {
            return Instruction{
                .mnemonic = "ROR", //INcrement Y
                .cycles = 6,
                .opcode = 0x76,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x6E => {
            return Instruction{
                .mnemonic = "ROR", //INcrement Y
                .cycles = 6,
                .opcode = 0x6E,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x7E => {
            return Instruction{
                .mnemonic = "ROR", //INcrement Y
                .cycles = 7,
                .opcode = 0x7E,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //RTI ( ReTurn from Interrupt )
        0x40 => {
            return Instruction{
                .mnemonic = "RTI", //INcrement Y
                .cycles = 6,
                .opcode = 0x40,
                .adressMode = "impl",
            };
        },

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
        0xE9 => {
            return Instruction{
                .mnemonic = "SBC",
                .cycles = 2,
                .opcode = 0xE9,
                .adressMode = "immd",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xE5 => {
            return Instruction{
                .mnemonic = "SBC",
                .cycles = 3,
                .opcode = 0xE5,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xF5 => {
            return Instruction{
                .mnemonic = "SBC",
                .cycles = 4,
                .opcode = 0xF5,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xED => {
            return Instruction{
                .mnemonic = "SBC",
                .cycles = 4,
                .opcode = 0xED,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xFD => {
            return Instruction{
                .mnemonic = "SBC",
                .cycles = 4,
                .opcode = 0xFD,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xF9 => {
            return Instruction{
                .mnemonic = "SBC",
                .cycles = 4,
                .opcode = 0xF9,
                .adressMode = "absY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xE1 => {
            return Instruction{
                .mnemonic = "SBC",
                .cycles = 6,
                .opcode = 0xE1,
                .adressMode = "indrX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xF1 => {
            return Instruction{
                .mnemonic = "SBC",
                .cycles = 5,
                .opcode = 0xF1,
                .adressMode = "indrY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },

        //STA ( STore Accumulator )
        0x85 => {
            return Instruction{
                .mnemonic = "STA",
                .cycles = 3,
                .opcode = 0x85,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x95 => {
            return Instruction{
                .mnemonic = "STA",
                .cycles = 4,
                .opcode = 0x95,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x8D => {
            return Instruction{
                .mnemonic = "STA",
                .cycles = 4,
                .opcode = 0x8D,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x9D => {
            return Instruction{
                .mnemonic = "STA",
                .cycles = 5,
                .opcode = 0x9D,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x99 => {
            return Instruction{
                .mnemonic = "STA",
                .cycles = 5,
                .opcode = 0x99,
                .adressMode = "absY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x81 => {
            return Instruction{
                .mnemonic = "STA",
                .cycles = 6,
                .opcode = 0x81,
                .adressMode = "indrX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x91 => {
            return Instruction{
                .mnemonic = "STA",
                .cycles = 6,
                .opcode = 0x91,
                .adressMode = "indrY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },

        //STX ( STore X register )
        0x86 => {
            return Instruction{
                .mnemonic = "STX",
                .cycles = 3,
                .opcode = 0x86,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x96 => {
            return Instruction{
                .mnemonic = "STX",
                .cycles = 4,
                .opcode = 0x96,
                .adressMode = "ZPY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x8E => {
            return Instruction{
                .mnemonic = "STX",
                .cycles = 4,
                .opcode = 0x8E,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //STY ( STore Y register )
        0x84 => {
            return Instruction{
                .mnemonic = "STY",
                .cycles = 3,
                .opcode = 0x84,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x94 => {
            return Instruction{
                .mnemonic = "STY",
                .cycles = 4,
                .opcode = 0x94,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x8C => {
            return Instruction{
                .mnemonic = "STY",
                .cycles = 4,
                .opcode = 0x8C,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //ORA ( bitwise OR with Accumulator )
        0x09 => {
            return Instruction{
                .mnemonic = "ORA",
                .cycles = 2,
                .opcode = 0x09,
                .adressMode = "immd",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x05 => {
            return Instruction{
                .mnemonic = "ORA",
                .cycles = 3,
                .opcode = 0x05,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x15 => {
            return Instruction{
                .mnemonic = "ORA",
                .cycles = 4,
                .opcode = 0x15,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x0D => {
            return Instruction{
                .mnemonic = "ORA",
                .cycles = 4,
                .opcode = 0x0D,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x1D => {
            return Instruction{
                .mnemonic = "ORA",
                .cycles = 4,
                .opcode = 0x1D,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x19 => {
            return Instruction{
                .mnemonic = "ORA",
                .cycles = 4,
                .opcode = 0x19,
                .adressMode = "absY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x01 => {
            return Instruction{
                .mnemonic = "ORA",
                .cycles = 6,
                .opcode = 0x01,
                .adressMode = "indrX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x11 => {
            return Instruction{
                .mnemonic = "ORA",
                .cycles = 5,
                .opcode = 0x01,
                .adressMode = "indrY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },

        //LSR ( Logical Shift Right )
        0x4A => {
            return Instruction{
                .mnemonic = "LSR",
                .cycles = 2,
                .opcode = 0x4A,
                .adressMode = "accum",
            };
        },
        0x46 => {
            return Instruction{
                .mnemonic = "LSR",
                .cycles = 5,
                .opcode = 0x46,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x56 => {
            return Instruction{
                .mnemonic = "LSR",
                .cycles = 6,
                .opcode = 0x56,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x4E => {
            return Instruction{
                .mnemonic = "LSR",
                .cycles = 6,
                .opcode = 0x4E,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x4E => {
            return Instruction{
                .mnemonic = "LSR",
                .cycles = 7,
                .opcode = 0x4E,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //LDY ( LoaD Y register )
        0xA0 => {
            return Instruction{
                .mnemonic = "LDY",
                .cycles = 2,
                .opcode = 0xA0,
                .adressMode = "immd",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xA4 => {
            return Instruction{
                .mnemonic = "LDY",
                .cycles = 3,
                .opcode = 0xA4,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xB4 => {
            return Instruction{
                .mnemonic = "LDY",
                .cycles = 4,
                .opcode = 0xB4,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xAC => {
            return Instruction{
                .mnemonic = "LDY",
                .cycles = 4,
                .opcode = 0xAC,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xBC => {
            return Instruction{
                .mnemonic = "LDY",
                .cycles = 4,
                .opcode = 0xBC,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //LDX ( LoaD X register )
        0xA2 => {
            return Instruction{
                .mnemonic = "LDX",
                .cycles = 2,
                .opcode = 0xA2,
                .adressMode = "immd",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xA6 => {
            return Instruction{
                .mnemonic = "LDX",
                .cycles = 3,
                .opcode = 0xA6,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xB6 => {
            return Instruction{
                .mnemonic = "LDX",
                .cycles = 4,
                .opcode = 0xB6,
                .adressMode = "ZPY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xAE => {
            return Instruction{
                .mnemonic = "LDX",
                .cycles = 4,
                .opcode = 0xAE,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xBE => {
            return Instruction{
                .mnemonic = "LDX",
                .cycles = 4,
                .opcode = 0xBE,
                .adressMode = "absY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //LDA ( LoaD Accumulator )
        0xA9 => {
            return Instruction{
                .mnemonic = "LDA",
                .cycles = 2,
                .opcode = 0xA9,
                .adressMode = "immd",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xA5 => {
            return Instruction{
                .mnemonic = "LDA",
                .cycles = 3,
                .opcode = 0xA5,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xB5 => {
            return Instruction{
                .mnemonic = "LDA",
                .cycles = 4,
                .opcode = 0xB5,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xAD => {
            return Instruction{
                .mnemonic = "LDA",
                .cycles = 4,
                .opcode = 0xAD,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xBD => {
            return Instruction{
                .mnemonic = "LDA",
                .cycles = 4,
                .opcode = 0xBD,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xB9 => {
            return Instruction{
                .mnemonic = "LDA",
                .cycles = 4,
                .opcode = 0xB9,
                .adressMode = "absY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xA1 => {
            return Instruction{
                .mnemonic = "LDA",
                .cycles = 6,
                .opcode = 0xA1,
                .adressMode = "indrX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xB1 => {
            return Instruction{
                .mnemonic = "LDA",
                .cycles = 5,
                .opcode = 0xB1,
                .adressMode = "indrY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },

        //JSR ( Jump to SubRoutine )
        0x20 => {
            return Instruction{
                .mnemonic = "JSR",
                .cycles = 6,
                .opcode = 0x20,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
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
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
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
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //INC ( INCrement memory )
        0xE6 => {
            return Instruction{
                .mnemonic = "INC",
                .cycles = 5,
                .opcode = 0xE6,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xF6 => {
            return Instruction{
                .mnemonic = "INC",
                .cycles = 6,
                .opcode = 0xF6,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xEE => {
            return Instruction{
                .mnemonic = "INC",
                .cycles = 6,
                .opcode = 0xEE,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xFE => {
            return Instruction{
                .mnemonic = "INC",
                .cycles = 7,
                .opcode = 0xFE,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //EOR ( bitwise Exclusive OR )
        0x49 => {
            return Instruction{
                .mnemonic = "EOR",
                .cycles = 2,
                .opcode = 0x49,
                .adressMode = "immd",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x45 => {
            return Instruction{
                .mnemonic = "EOR",
                .cycles = 3,
                .opcode = 0x45,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x55 => {
            return Instruction{
                .mnemonic = "EOR",
                .cycles = 4,
                .opcode = 0x55,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x4D => {
            return Instruction{
                .mnemonic = "EOR",
                .cycles = 4,
                .opcode = 0x4D,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x5D => {
            return Instruction{
                .mnemonic = "EOR",
                .cycles = 4,
                .opcode = 0x5D,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x59 => {
            return Instruction{
                .mnemonic = "EOR",
                .cycles = 4,
                .opcode = 0x59,
                .adressMode = "absY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0x41 => {
            return Instruction{
                .mnemonic = "EOR",
                .cycles = 6,
                .opcode = 0x41,
                .adressMode = "indrX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x51 => {
            return Instruction{
                .mnemonic = "EOR",
                .cycles = 5,
                .opcode = 0x51,
                .adressMode = "indrY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },

        //DEC ( DECrement memory )
        0xC6 => {
            return Instruction{
                .mnemonic = "DEC",
                .cycles = 5,
                .opcode = 0xC6,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xD6 => {
            return Instruction{
                .mnemonic = "DEC",
                .cycles = 6,
                .opcode = 0xD6,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xCE => {
            return Instruction{
                .mnemonic = "DEC",
                .cycles = 6,
                .opcode = 0xCE,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xDE => {
            return Instruction{
                .mnemonic = "DEC",
                .cycles = 7,
                .opcode = 0xDE,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //CPY ( ComPare Y register )
        0xC0 => {
            return Instruction{
                .mnemonic = "CPY",
                .cycles = 2,
                .opcode = 0xC0,
                .adressMode = "immd",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xC4 => {
            return Instruction{
                .mnemonic = "CPY",
                .cycles = 3,
                .opcode = 0xC4,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xCC => {
            return Instruction{
                .mnemonic = "CPY",
                .cycles = 3,
                .opcode = 0xCC,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //CPX ( ComPare X register )
        0xE0 => {
            return Instruction{
                .mnemonic = "CPX",
                .cycles = 2,
                .opcode = 0xE0,
                .adressMode = "immd",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xE4 => {
            return Instruction{
                .mnemonic = "CPX",
                .cycles = 3,
                .opcode = 0xE4,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xEC => {
            return Instruction{
                .mnemonic = "CPX",
                .cycles = 3,
                .opcode = 0xEC,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //CMP ( CoMPare accumulator )
        0xC9 => {
            return Instruction{
                .mnemonic = "CMP",
                .cycles = 2,
                .opcode = 0xC9,
                .adressMode = "immd",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xC5 => {
            return Instruction{
                .mnemonic = "CMP",
                .cycles = 3,
                .opcode = 0xC5,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xD5 => {
            return Instruction{
                .mnemonic = "CMP",
                .cycles = 4,
                .opcode = 0xD5,
                .adressMode = "ZPX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xCD => {
            return Instruction{
                .mnemonic = "CMP",
                .cycles = 4,
                .opcode = 0xCD,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xDD => {
            return Instruction{
                .mnemonic = "CMP",
                .cycles = 4,
                .opcode = 0xDD,
                .adressMode = "absX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xD9 => {
            return Instruction{
                .mnemonic = "CMP",
                .cycles = 4,
                .opcode = 0xD9,
                .adressMode = "absY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },
        0xC1 => {
            return Instruction{
                .mnemonic = "CMP",
                .cycles = 6,
                .opcode = 0xC1,
                .adressMode = "indrX",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xD1 => {
            return Instruction{
                .mnemonic = "CMP",
                .cycles = 5,
                .opcode = 0xD1,
                .adressMode = "indrY",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },

        //BRK ( BReaK )
        0x00 => {
            return Instruction{
                .mnemonic = "BRK",
                .cycles = 7,
                .opcode = 0x00,
                .adressMode = "impl",
            };
        },

        //Branch Instructions
        //These are unique relative mode addressing, 2 cycles if not taken, 1 more if taken, 1 more if page boundry crossed.
        //For that reason we are starting at 2 cycles and will adjust on the fly as needed
        0x10 => {
            return Instruction{
                .mnemonic = "BPL", //Branch on Plus
                .cycles = 2,
                .opcode = 0x10,
                .adressMode = "rel",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x30 => {
            return Instruction{
                .mnemonic = "BMI", //Branch on MInus
                .cycles = 2,
                .opcode = 0x30,
                .adressMode = "rel",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x50 => {
            return Instruction{
                .mnemonic = "BVC", //Branch on oVerflow Clear
                .cycles = 2,
                .opcode = 0x50,
                .adressMode = "rel",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x70 => {
            return Instruction{
                .mnemonic = "BVS", //Branch on oVerflow Set
                .cycles = 2,
                .opcode = 0x70,
                .adressMode = "rel",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x90 => {
            return Instruction{
                .mnemonic = "BCC", //Branch on Carry Clear
                .cycles = 2,
                .opcode = 0x90,
                .adressMode = "rel",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xB0 => {
            return Instruction{
                .mnemonic = "BCS", //Branch on Carry Set
                .cycles = 2,
                .opcode = 0xB0,
                .adressMode = "rel",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xD0 => {
            return Instruction{
                .mnemonic = "BNE", //Branch on Not Equal
                .cycles = 2,
                .opcode = 0xD0,
                .adressMode = "rel",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0xF0 => {
            return Instruction{
                .mnemonic = "BCS", //Branch on EQual
                .cycles = 2,
                .opcode = 0xF0,
                .adressMode = "rel",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },

        //BIT ( test BITs )
        0x24 => {
            return Instruction{
                .mnemonic = "BIT",
                .cycles = 3,
                .opcode = 0x24,
                .adressMode = "ZP",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
            };
        },
        0x2C => {
            return Instruction{
                .mnemonic = "BIT",
                .cycles = 4,
                .opcode = 0x2C,
                .adressMode = "abs",
                .operand1 = Memory.memorySpace.getByte(cpu.PC + 1),
                .operand2 = Memory.memorySpace.getByte(cpu.PC + 2),
            };
        },

        //ASL ( Arithmetic Shift Left )

        //AND ( bitwise AND with accumulator )

        //ADC ( ADd with Carry )

        //Yeah shit is wrong if we dont recognize the opcode lol
        else => {
            return anyerror;
        },
    }
}
