# ===----------------------------------------------------------------------=== #
# enums.mojo — Trading enums (交易列舉型別)
#
# Mojo has no native enum keyword. Each enum is a struct with comptime
# constants and an Int discriminant.
#
# Exports: Side, PositionSide, OrderType, OrderStatus
# ===----------------------------------------------------------------------=== #


@fieldwise_init
struct Side(ImplicitlyCopyable, Writable):
    """Trade direction. 交易方向。

    Values:
        BUY  (0) — Buy / 買入
        SELL (1) — Sell / 賣出

    Example:
        var s = Side.BUY
        if s.is_buy():
            print("buying")
    """

    var value: Int
    """Internal discriminant: 0=BUY, 1=SELL."""

    comptime BUY = Side(0)
    comptime SELL = Side(1)

    fn __copyinit__(out self, copy: Side):
        self.value = copy.value

    fn __eq__(self, other: Side) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: Side) -> Bool:
        return self.value != other.value

    fn is_buy(self) -> Bool:
        """Returns True if this is BUY."""
        return self.value == 0

    fn is_sell(self) -> Bool:
        """Returns True if this is SELL."""
        return self.value == 1

    fn write_to[W: Writer](self, mut writer: W):
        if self.value == 0:
            writer.write("BUY")
        else:
            writer.write("SELL")

    fn __str__(self) -> String:
        return String.write(self)


# -----------------------------------------------------------------------


@fieldwise_init
struct PositionSide(ImplicitlyCopyable, Writable):
    """Position direction. 持倉方向。

    Values:
        FLAT  (0) — No position / 空倉
        LONG  (1) — Long / 多頭
        SHORT (2) — Short / 空頭

    Example:
        var ps = PositionSide.LONG
        if ps.is_long():
            print("holding long")
    """

    var value: Int
    """Internal discriminant: 0=FLAT, 1=LONG, 2=SHORT."""

    comptime FLAT = PositionSide(0)
    comptime LONG = PositionSide(1)
    comptime SHORT = PositionSide(2)

    fn __copyinit__(out self, copy: PositionSide):
        self.value = copy.value

    fn __eq__(self, other: PositionSide) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: PositionSide) -> Bool:
        return self.value != other.value

    fn is_flat(self) -> Bool:
        """Returns True if no position (FLAT)."""
        return self.value == 0

    fn is_long(self) -> Bool:
        """Returns True if LONG."""
        return self.value == 1

    fn is_short(self) -> Bool:
        """Returns True if SHORT."""
        return self.value == 2

    fn write_to[W: Writer](self, mut writer: W):
        if self.value == 0:
            writer.write("FLAT")
        elif self.value == 1:
            writer.write("LONG")
        else:
            writer.write("SHORT")

    fn __str__(self) -> String:
        return String.write(self)


# -----------------------------------------------------------------------


@fieldwise_init
struct OrderType(ImplicitlyCopyable, Writable):
    """Order type. 訂單類型。

    Values:
        MARKET (0) — Market order / 市價單
        LIMIT  (1) — Limit order / 限價單

    Example:
        var ot = OrderType.LIMIT
        if ot.is_limit():
            print("limit order")
    """

    var value: Int
    """Internal discriminant: 0=MARKET, 1=LIMIT."""

    comptime MARKET = OrderType(0)
    comptime LIMIT = OrderType(1)

    fn __copyinit__(out self, copy: OrderType):
        self.value = copy.value

    fn __eq__(self, other: OrderType) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: OrderType) -> Bool:
        return self.value != other.value

    fn is_market(self) -> Bool:
        """Returns True if MARKET."""
        return self.value == 0

    fn is_limit(self) -> Bool:
        """Returns True if LIMIT."""
        return self.value == 1

    fn write_to[W: Writer](self, mut writer: W):
        if self.value == 0:
            writer.write("MARKET")
        else:
            writer.write("LIMIT")

    fn __str__(self) -> String:
        return String.write(self)


# -----------------------------------------------------------------------


@fieldwise_init
struct OrderStatus(ImplicitlyCopyable, Writable):
    """Order lifecycle status. 訂單狀態。

    Values:
        PENDING   (0) — Awaiting execution / 待處理
        FILLED    (1) — Fully executed / 已成交
        CANCELLED (2) — Cancelled by user / 已取消
        REJECTED  (3) — Rejected by exchange / 已拒絕

    Example:
        var os = OrderStatus.PENDING
        if os.is_filled():
            print("order filled!")
    """

    var value: Int
    """Internal discriminant: 0=PENDING, 1=FILLED, 2=CANCELLED, 3=REJECTED."""

    comptime PENDING = OrderStatus(0)
    comptime FILLED = OrderStatus(1)
    comptime CANCELLED = OrderStatus(2)
    comptime REJECTED = OrderStatus(3)

    fn __copyinit__(out self, copy: OrderStatus):
        self.value = copy.value

    fn __eq__(self, other: OrderStatus) -> Bool:
        return self.value == other.value

    fn __ne__(self, other: OrderStatus) -> Bool:
        return self.value != other.value

    fn is_pending(self) -> Bool:
        """Returns True if PENDING."""
        return self.value == 0

    fn is_filled(self) -> Bool:
        """Returns True if FILLED."""
        return self.value == 1

    fn is_cancelled(self) -> Bool:
        """Returns True if CANCELLED."""
        return self.value == 2

    fn is_rejected(self) -> Bool:
        """Returns True if REJECTED."""
        return self.value == 3

    fn write_to[W: Writer](self, mut writer: W):
        if self.value == 0:
            writer.write("PENDING")
        elif self.value == 1:
            writer.write("FILLED")
        elif self.value == 2:
            writer.write("CANCELLED")
        else:
            writer.write("REJECTED")

    fn __str__(self) -> String:
        return String.write(self)
