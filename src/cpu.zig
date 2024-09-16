const std = @import("std");

const CPU = struct {
    PC: u16,
    SP: u8,
    Status: u8,
    Accumulator: u8,
    X: u8,
    Y: u8,

    pub fn nextInstr(self: CPU) !void {
        self.PC += 1;

        return void;
    }
};
