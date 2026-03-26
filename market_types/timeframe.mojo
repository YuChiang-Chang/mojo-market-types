# ===----------------------------------------------------------------------=== #
# timeframe.mojo — Candlestick / bar period (時間週期)
#
# Represents the duration of a single candlestick bar.
# Stored as seconds (Int). TICK is special-cased as 0.
#
# Exports: Timeframe
# ===----------------------------------------------------------------------=== #


@fieldwise_init
struct Timeframe(ImplicitlyCopyable, Writable):
    """Candlestick time period. 時間週期。

    Each constant stores the period length in seconds.
    Use seconds() to retrieve the numeric value.

    Constants:
        TICK (0s) — Tick-level data
        M1   (60s)   — 1 minute
        M5   (300s)  — 5 minutes
        M15  (900s)  — 15 minutes
        H1   (3600s) — 1 hour
        H4   (14400s)— 4 hours
        D1   (86400s)— 1 day

    Example:
        var tf = Timeframe.H1
        print(tf.__str__())      # "1h"
        print(tf.seconds())      # 3600
    """

    var value: Int
    """Period length in seconds. 0 means tick."""

    comptime TICK = Timeframe(0)
    comptime M1 = Timeframe(60)
    comptime M5 = Timeframe(300)
    comptime M15 = Timeframe(900)
    comptime H1 = Timeframe(3600)
    comptime H4 = Timeframe(14400)
    comptime D1 = Timeframe(86400)

    fn __copyinit__(out self, copy: Timeframe):
        self.value = copy.value

    fn __eq__(self, other: Timeframe) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: Timeframe) -> Bool:
        return self.value != other.value

    fn seconds(self) -> Int:
        """Returns period length in seconds."""
        return self.value

    fn write_to[W: Writer](self, mut writer: W):
        if self.value == 0:
            writer.write("TICK")
        elif self.value == 60:
            writer.write("1m")
        elif self.value == 300:
            writer.write("5m")
        elif self.value == 900:
            writer.write("15m")
        elif self.value == 3600:
            writer.write("1h")
        elif self.value == 14400:
            writer.write("4h")
        elif self.value == 86400:
            writer.write("1d")
        else:
            writer.write("Timeframe(")
            writer.write(String(self.value))
            writer.write("s)")

    fn __str__(self) -> String:
        return String.write(self)
