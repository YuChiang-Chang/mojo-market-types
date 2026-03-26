# ===----------------------------------------------------------------------=== #
# main.mojo — Demo / 型別使用範例
#
# 此檔案展示如何匯入並使用 market_types 中所有型別。
# 可直接執行: mojo main.mojo
# ===----------------------------------------------------------------------=== #

from market_types import (
    Side,
    PositionSide,
    OrderType,
    OrderStatus,
    Timestamp,
    Timeframe,
    Symbol,
    OHLCVBar,
    Quote,
    Order,
    Trade,
    Position,
)


fn main() raises:
    print("=== mojo-market-types v0.1.0 ===\n")

    # -- Enums --
    var buy = Side.BUY
    var sell = Side.SELL
    print("Side:        " + buy.__str__() + " / " + sell.__str__())
    print("OrderType:   " + OrderType.MARKET.__str__() + " / " + OrderType.LIMIT.__str__())
    print("OrderStatus: " + OrderStatus.PENDING.__str__())
    print("PositionSide:" + PositionSide.LONG.__str__() + "\n")

    # -- Timestamp --
    var t1 = Timestamp(1700000000000)
    var t2 = Timestamp(1700000060000)
    print("Timestamp:   " + t1.__str__())
    print("t1 < t2:     " + String(t1 < t2) + "\n")

    # -- Timeframe --
    var tf = Timeframe.H1
    print("Timeframe:   " + tf.__str__() + " (" + String(tf.seconds()) + "s)\n")

    # -- Symbol --
    print("Symbol:      " + Symbol("BTCUSDT").__str__() + "\n")

    # -- OHLCVBar --
    var bar = OHLCVBar(1700000000000, 42000.0, 42500.0, 41800.0, 42300.0, 150.5)
    print("OHLCVBar:    " + bar.__str__() + "\n")

    # -- Quote --
    var q = Quote(1700000000000, 42000.0, 42001.0)
    print("Quote:       " + q.__str__())
    print("Spread:      " + String(q.spread()) + "\n")

    # -- Order --
    var order = Order(
        id=1, symbol="BTCUSDT", side=Side.BUY,
        order_type=OrderType.LIMIT, quantity=0.5,
        price=42000.0, status=OrderStatus.PENDING,
    )
    print("Order:       " + order.__str__() + "\n")

    # -- Trade --
    var trade = Trade(
        id=1, order_id=1, symbol="BTCUSDT",
        side=Side.BUY, quantity=0.5,
        price=42000.0, fee=21.0,
    )
    print("Trade:       " + trade.__str__() + "\n")

    # -- Position --
    var pos = Position(
        symbol="BTCUSDT", side=PositionSide.LONG,
        quantity=0.5, avg_price=42000.0,
        unrealized_pnl=150.0,
    )
    print("Position:    " + pos.__str__() + "\n")

    print("=== All types loaded successfully! ===")
