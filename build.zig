const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    const lib = b.addLibrary(.{
        .name = "ogg",
        .linkage = .static,
        .root_module = mod,
    });

    lib.addIncludePath(b.path("include"));
    lib.addCSourceFiles(.{
        .files = &.{
            "src/bitwise.c",
            "src/framing.c",
        },
        .flags = &.{
            "-std=c99",
        },
    });
    lib.linkLibC();
    lib.installHeadersDirectory(b.path("include/ogg"), "ogg", .{});
    b.installArtifact(lib);
}
