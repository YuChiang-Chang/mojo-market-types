# ===----------------------------------------------------------------------=== #
# trade.mojo — Executed trade / fill (成交記錄)
#
# Represents a single fill against an order.
# Validates: quantity > 0, price > 0.
#
# Exports: Trade
# ===----------------------------------------------------------------------=== #

from .enums import Side


struct Trade(Writable):
    """Executed trade (fill). 成交記錄。

    A single execution / fill resulting from an Order.

    Fields:
        id:       Int     — Unique trade identifier.
        order_id: Int     — Parent order ID.
        symbol:   String  — Instrument (e.g. "BTCUSDT").
        side:     Side    — BUY or SELL.
        quantity: Float64 — Filled quantity (must be > 0).
        price:    Float64 — Execution price (must be > 0).
        fee:      Float64 — Transaction fee.

    Validation (raises Error):
        - quantity > 0
        - price > 0

    Example:
        var trade = Trade(
            id=1, order_id=100, symbol="BTCUSDT",
            side=Side.BUY, quantity=0.5,
            price=42000.0, fee=21.0,
        )
    """

    var id: Int
    """Unique trade identifier."""
    var order_id: Int
    """Parent order that generated this fill."""
    var symbol: String
    """Instrument ticker."""
    var side: Side
    """Trade direction: BUY or SELL."""
    var quantity: Float64
    """Filled quantity (must be > 0)."""
    var price: Float64
    """Execution price (must be > 0)."""
    var fee: Float64
    """Transaction fee charged."""

    fn __init__(
        out self,
        id: Int,
        order_id: Int,
        symbol: String,
        side: Side,
        quantity: Float64,
        price: Float64,
        fee: Float64,
    ) raises:
        if quantity <= 0:
            raise Error("Trade: quantity must be > 0")
        if price <= 0:
            raise Error("Trade: price must be > 0")
        self.id = id
        self.order_id = order_id
        self.symbol = symbol
        self.side = side
        self.quantity = quantity
        self.price = price
        self.fee = fee

    fn __copyinit__(out self, copy: Trade):
        self.id = copy.id
        self.order_id = copy.order_id
        self.symbol = copy.symbol
        self.side = copy.side
        self.quantity = copy.quantity
        self.price = copy.price
        self.fee = copy.fee

    fn write_to[W: Writer](self, mut writer: W):
        writer.write("Trade(id=")
        writer.write(String(self.id))
        writer.write(", order_id=")
        writer.write(String(self.order_id))
        writer.write(", symbol=")
        writer.write(self.symbol)
        writer.write(", side=")
        writer.write(self.side.__str__())
        writer.write(", qty=")
        writer.write(String(self.quantity))
        writer.write(", price=")
        writer.write(String(self.price))
        writer.write(", fee=")
        writer.write(String(self.fee))
        writer.write(")")

    fn __str__(self) -> String:
        return String.write(self)
