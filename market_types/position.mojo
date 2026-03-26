# ===----------------------------------------------------------------------=== #
# position.mojo — Open position (持倉)
#
# Tracks the current exposure on a single instrument.
#
# Exports: Position
# ===----------------------------------------------------------------------=== #

from .enums import PositionSide


struct Position(Writable):
    """Open position on a single instrument. 持倉資訊。

    Represents the trader's current exposure for one symbol.

    Fields:
        symbol:          String       — Instrument (e.g. "BTCUSDT").
        side:            PositionSide — FLAT, LONG, or SHORT.
        quantity:        Float64      — Position size.
        avg_price:       Float64      — Average entry price.
        unrealized_pnl:  Float64      — Mark-to-market P&L.

    Convenience methods:
        is_flat()  -> Bool
        is_long()  -> Bool
        is_short() -> Bool

    Example:
        var pos = Position(
            symbol="BTCUSDT", side=PositionSide.LONG,
            quantity=0.5, avg_price=42000.0,
            unrealized_pnl=150.0,
        )
        if pos.is_long():
            print("holding long")
    """

    var symbol: String
    """Instrument ticker."""
    var side: PositionSide
    """Position direction: FLAT, LONG, or SHORT."""
    var quantity: Float64
    """Position size in base units."""
    var avg_price: Float64
    """Average entry price."""
    var unrealized_pnl: Float64
    """Unrealized profit/loss (mark-to-market)."""

    fn __init__(
        out self,
        symbol: String,
        side: PositionSide,
        quantity: Float64,
        avg_price: Float64,
        unrealized_pnl: Float64,
    ):
        self.symbol = symbol
        self.side = side
        self.quantity = quantity
        self.avg_price = avg_price
        self.unrealized_pnl = unrealized_pnl

    fn __copyinit__(out self, copy: Position):
        self.symbol = copy.symbol
        self.side = copy.side
        self.quantity = copy.quantity
        self.avg_price = copy.avg_price
        self.unrealized_pnl = copy.unrealized_pnl

    fn is_flat(self) -> Bool:
        """Returns True if position is FLAT (no exposure)."""
        return self.side.is_flat()

    fn is_long(self) -> Bool:
        """Returns True if holding a LONG position."""
        return self.side.is_long()

    fn is_short(self) -> Bool:
        """Returns True if holding a SHORT position."""
        return self.side.is_short()

    fn write_to[W: Writer](self, mut writer: W):
        writer.write("Position(symbol=")
        writer.write(self.symbol)
        writer.write(", side=")
        writer.write(self.side.__str__())
        writer.write(", qty=")
        writer.write(String(self.quantity))
        writer.write(", avg_price=")
        writer.write(String(self.avg_price))
        writer.write(", pnl=")
        writer.write(String(self.unrealized_pnl))
        writer.write(")")

    fn __str__(self) -> String:
        return String.write(self)
