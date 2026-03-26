# ===----------------------------------------------------------------------=== #
# ohlcv_bar.mojo — OHLCV candlestick bar (K 線)
#
# A single candlestick with open/high/low/close prices and volume.
# Validates: high >= low, volume >= 0.
#
# Exports: OHLCVBar
# ===----------------------------------------------------------------------=== #


struct OHLCVBar(Writable):
    """OHLCV candlestick bar. K 線資料。

    Represents a single candlestick with price and volume data.
    The constructor validates data integrity and raises on invalid input.

    Fields:
        timestamp: Int     — Bar open time (Unix ms).
        open:      Float64 — Opening price.
        high:      Float64 — Highest price in period.
        low:       Float64 — Lowest price in period.
        close:     Float64 — Closing price.
        volume:    Float64 — Traded volume.

    Validation (raises Error):
        - high >= low
        - volume >= 0

    Example:
        var bar = OHLCVBar(1700000000000, 100.0, 110.0, 90.0, 105.0, 5000.0)
    """

    var timestamp: Int
    """Bar open time in Unix milliseconds."""
    var open: Float64
    """Opening price."""
    var high: Float64
    """Highest price during this bar's period."""
    var low: Float64
    """Lowest price during this bar's period."""
    var close: Float64
    """Closing price."""
    var volume: Float64
    """Traded volume (must be >= 0)."""

    fn __init__(
        out self,
        timestamp: Int,
        open: Float64,
        high: Float64,
        low: Float64,
        close: Float64,
        volume: Float64,
    ) raises:
        if high < low:
            raise Error("OHLCVBar: high must be >= low")
        if volume < 0:
            raise Error("OHLCVBar: volume must be >= 0")
        self.timestamp = timestamp
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume

    fn __copyinit__(out self, copy: OHLCVBar):
        self.timestamp = copy.timestamp
        self.open = copy.open
        self.high = copy.high
        self.low = copy.low
        self.close = copy.close
        self.volume = copy.volume

    fn write_to[W: Writer](self, mut writer: W):
        writer.write("OHLCVBar(ts=")
        writer.write(String(self.timestamp))
        writer.write(", o=")
        writer.write(String(self.open))
        writer.write(", h=")
        writer.write(String(self.high))
        writer.write(", l=")
        writer.write(String(self.low))
        writer.write(", c=")
        writer.write(String(self.close))
        writer.write(", v=")
        writer.write(String(self.volume))
        writer.write(")")

    fn __str__(self) -> String:
        return String.write(self)
