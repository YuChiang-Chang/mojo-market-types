# ===----------------------------------------------------------------------=== #
# timestamp.mojo — Unix-millisecond timestamp (時間戳記)
#
# A thin wrapper around Int representing Unix time in milliseconds.
# Supports full comparison operators (<, <=, ==, !=, >, >=).
#
# Exports: Timestamp
# ===----------------------------------------------------------------------=== #


struct Timestamp(ImplicitlyCopyable, Writable):
    """Unix-millisecond timestamp. 時間戳記（毫秒）。

    A lightweight wrapper around an Int value representing milliseconds
    since the Unix epoch (1970-01-01 00:00:00 UTC).

    Fields:
        value: Int — Unix timestamp in milliseconds.

    Supports: <, <=, ==, !=, >, >=

    Example:
        var t1 = Timestamp(1700000000000)
        var t2 = Timestamp(1700000060000)
        if t1 < t2:
            print("t1 is earlier")
    """

    var value: Int
    """Unix timestamp in milliseconds since epoch."""

    fn __init__(out self, value: Int):
        self.value = value

    fn __copyinit__(out self, copy: Timestamp):
        self.value = copy.value

    fn __lt__(self, other: Timestamp) -> Bool:
        return self.value < other.value

    fn __le__(self, other: Timestamp) -> Bool:
        return self.value <= other.value

    fn __eq__(self, other: Timestamp) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: Timestamp) -> Bool:
        return self.value != other.value

    fn __gt__(self, other: Timestamp) -> Bool:
        return self.value > other.value

    fn __ge__(self, other: Timestamp) -> Bool:
        return self.value >= other.value

    fn write_to[W: Writer](self, mut writer: W):
        writer.write("Timestamp(")
        writer.write(String(self.value))
        writer.write(")")

    fn __str__(self) -> String:
        return String.write(self)
