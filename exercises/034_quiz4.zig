//
// Quiz time. See if you can make this program work!
//
// Solve this any way you like, just be sure the output is:
//
//     my_num=42
//
const std = @import("std");
const stdout = std.io.getStdOut().writer();

const NumError = error{
    IllegalNumber,
    TrashExampleError,
};

pub fn main() !void {
    const my_num: u8 = getNumber() catch |err| handle_err: {
        break :handle_err switch (err) {
            NumError.IllegalNumber => getRandInt(u8),
            NumError.TrashExampleError => 4,
        };
    };

    try stdout.print("my_num={}\n", .{my_num});
}

// This function is obviously weird and non-functional. But you will not be changing it for this quiz.
fn getNumber() NumError!u8 {
    if (false) return NumError.IllegalNumber;
    return 42;
}

fn getRandInt(comptime IntType: type) IntType {
    var prng = std.rand.DefaultPrng.init(seed_gen: {
        var seed: u64 = undefined;
        std.os.getrandom(std.mem.asBytes(&seed)) catch {
            break :seed_gen 55;
        };
        break :seed_gen seed;
    });
    return prng.random().int(IntType);
}
