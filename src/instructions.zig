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
