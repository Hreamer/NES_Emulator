const std = @import("std");

const Memory = struct {
    MemSpace: [65535]u8 = std.mem.zeroes([65535]u8),

    pub fn getByte(self: Memory, location: u16) !u8 {
        if (location >= self.MemSpace.len) {
            return anyerror;
        } else {
            return self.MemSpace[location];
        }
    }
};

var memorySpace: Memory = Memory();
