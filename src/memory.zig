const std = @import("std");

const Memory = struct {
    ROM: [*]u8,
    BIOS: [*]u8,
};
