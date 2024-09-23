const std = @import("std");
const Memory = @import("memory.zig");
const Instructions = @import("instructions.zig");

const CPU = struct {
    //Registers
    PC: u16,
    SP: u8,
    Status: u8 = 0b00100000, //read the docs for this each bit matters
    Accumulator: u8,
    X: u8,
    Y: u8,

    pub fn executeInstr(self: CPU) !void {
        //remember that we need to check for interrupts every step which includes before the next instruction is run

        const instruction = Instructions.decode(self, Memory.memorySpace.getByte(self.PC));

        //if there was no error than we handle the returned instruction otherwise propagate the error upward
        if (instruction) |instr| {
            //time to start disecting the command
            _ = instr;
        } else |err| {
            return err;
        }

        return void;
    }

    pub fn stackPush(self: CPU, value: u8) void {
        Memory.memorySpace.writeByte(0x100 | @as(u16, self.SP), value);
        self.SP -%= 1;
    }

    pub fn stackPop(self: CPU) !u8 {
        self.SP +%= 1;
        return Memory.memorySpace.getByte(0x100 | @as(u16, self.SP));
    }
};
