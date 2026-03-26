# ===----------------------------------------------------------------------=== #
# quote.mojo — Bid/ask quote (即時報價)
#
# A snapshot of the best bid and ask prices at a given moment.
#
# Exports: Quote
# ===----------------------------------------------------------------------=== #


struct Quote(Writable):
    """Bid/ask quote snapshot. 即時報價。

    Captures the best bid and ask at a point in time.

    Fields:
        timestamp: Int     — Quote time (Unix ms).
        bid:       Float64 — Best bid price.
        ask:       Float64 — Best ask price.

    Methods:
        spread() -> Float64 — Returns ask - bid.

    Example:
        var q = Quote(1700000000000, 42000.0, 42001.0)
        print(q.spread())  # 1.0
    """

    var timestamp: Int
    """Quote time in Unix milliseconds."""
    var bid: Float64
    """Best bid (buy) price."""
    var ask: Float64
    """Best ask (sell) price."""

    fn __init__(out self, timestamp: Int, bid: Float64, ask: Float64):
        self.timestamp = timestamp
        self.bid = bid
        self.ask = ask

    fn __copyinit__(out self, copy: Quote):
        self.timestamp = copy.timestamp
        self.bid = copy.bid
        self.ask = copy.ask

    fn spread(self) -> Float64:
        """Returns the bid-ask spread (ask - bid)."""
        return self.ask - self.bid

    fn write_to[W: Writer](self, mut writer: W):
        writer.write("Quote(ts=")
        writer.write(String(self.timestamp))
        writer.write(", bid=")
        writer.write(String(self.bid))
        writer.write(", ask=")
        writer.write(String(self.ask))
        writer.write(")")

    fn __str__(self) -> String:
        return String.write(self)
