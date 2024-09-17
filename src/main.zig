const std = @import("std");
const CPU = @import("cpu.zig");

//Init the CPU
var processor = CPU.cpu{};

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    while (true) {
        processor.executeInstr();
    }
}
