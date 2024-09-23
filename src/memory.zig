const std = @import("std");

const Memory = struct {
    MemSpace: [65535]u8 = std.mem.zeroes([65535]u8),

    pub fn getByte(self: Memory, location: u16) !u8 {
        if (location > self.MemSpace.len) {
            return anyerror;
        } else if (0 > location) {
            return anyerror;
        } else {
            return self.MemSpace[location];
        }
    }

    pub fn writeByte(self: Memory, location: u16, value: u8) !void {
        if (location > self.MemSpace.len) {
            return anyerror;
        } else if (0 > location) {
            return anyerror;
        } else {
            self.MemSpace[location] = value;
        }
    }
};

var memorySpace: Memory = Memory();
