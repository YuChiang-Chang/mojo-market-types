# ===----------------------------------------------------------------------=== #
# order.mojo — Trading order (交易訂單)
#
# Represents a single order submitted to an exchange.
# Validates: quantity > 0, limit orders require price > 0.
#
# Exports: Order
# ===----------------------------------------------------------------------=== #

from .enums import Side, OrderType, OrderStatus


struct Order(Writable):
    """Trading order. 交易訂單。

    An order submitted to an exchange/broker for execution.
    The constructor validates business rules and raises on invalid input.

    Fields:
        id:         Int         — Unique order identifier.
        symbol:     String      — Instrument (e.g. "BTCUSDT").
        side:       Side        — BUY or SELL.
        order_type: OrderType   — MARKET or LIMIT.
        quantity:   Float64     — Order size (must be > 0).
        price:      Float64     — Limit price (required > 0 for LIMIT).
        status:     OrderStatus — Current lifecycle status.

    Validation (raises Error):
        - quantity > 0
        - If order_type == LIMIT, then price > 0

    Example:
        var order = Order(
            id=1, symbol="BTCUSDT", side=Side.BUY,
            order_type=OrderType.LIMIT, quantity=0.5,
            price=42000.0, status=OrderStatus.PENDING,
        )
    """

    var id: Int
    """Unique order identifier."""
    var symbol: String
    """Instrument ticker (e.g. "BTCUSDT")."""
    var side: Side
    """Trade direction: BUY or SELL."""
    var order_type: OrderType
    """Order type: MARKET or LIMIT."""
    var quantity: Float64
    """Order size (must be > 0)."""
    var price: Float64
    """Limit price. Must be > 0 for LIMIT orders; ignored for MARKET."""
    var status: OrderStatus
    """Current lifecycle status."""

    fn __init__(
        out self,
        id: Int,
        symbol: String,
        side: Side,
        order_type: OrderType,
        quantity: Float64,
        price: Float64,
        status: OrderStatus,
    ) raises:
        if quantity <= 0:
            raise Error("Order: quantity must be > 0")
        if order_type == OrderType.LIMIT and price <= 0:
            raise Error("Order: limit order must have price > 0")
        self.id = id
        self.symbol = symbol
        self.side = side
        self.order_type = order_type
        self.quantity = quantity
        self.price = price
        self.status = status

    fn __copyinit__(out self, copy: Order):
        self.id = copy.id
        self.symbol = copy.symbol
        self.side = copy.side
        self.order_type = copy.order_type
        self.quantity = copy.quantity
        self.price = copy.price
        self.status = copy.status

    fn write_to[W: Writer](self, mut writer: W):
        writer.write("Order(id=")
        writer.write(String(self.id))
        writer.write(", symbol=")
        writer.write(self.symbol)
        writer.write(", side=")
        writer.write(self.side.__str__())
        writer.write(", type=")
        writer.write(self.order_type.__str__())
        writer.write(", qty=")
        writer.write(String(self.quantity))
        writer.write(", price=")
        writer.write(String(self.price))
        writer.write(", status=")
        writer.write(self.status.__str__())
        writer.write(")")

    fn __str__(self) -> String:
        return String.write(self)
