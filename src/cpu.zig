const std = @import("std");
const Memory = @import("memory.zig");

const CPU = struct {
    PC: u16,
    SP: u8,
    Status: u8, //read the docs for this each bit matters
    Accumulator: u8,
    X: u8,
    Y: u8,

    pub fn executeInstr(self: CPU) !void {
        //remember that we need to check for interrupts every step which includes before the next instruction is run

        const instruction = Memory.memorySpace.getByte(self.PC);

        //if there was no error than we handle the returned instruction otherwise propagate the error upward
        if (instruction) |instr| {
            //time to start disecting the command
            _ = instr; //del later
        } else |err| {
            return err;
        }

        return void;
    }
};
