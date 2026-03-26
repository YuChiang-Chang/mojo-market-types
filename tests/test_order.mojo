# test_order.mojo — Tests for Order validation

from std.testing import assert_true, assert_equal
from market_types import Order, Side, OrderType, OrderStatus


fn test_market_order() raises:
    var o = Order(
        id=1, symbol="BTCUSDT", side=Side.BUY,
        order_type=OrderType.MARKET, quantity=1.0,
        price=0.0, status=OrderStatus.PENDING,
    )
    assert_equal(o.id, 1)
    assert_true(o.side == Side.BUY, "side BUY")
    assert_true(o.order_type == OrderType.MARKET, "type MARKET")
    print("  ✓ valid market order")


fn test_limit_order() raises:
    var o = Order(
        id=2, symbol="ETHUSDT", side=Side.SELL,
        order_type=OrderType.LIMIT, quantity=10.0,
        price=3000.0, status=OrderStatus.PENDING,
    )
    assert_true(o.order_type == OrderType.LIMIT, "type LIMIT")
    assert_equal(o.price, 3000.0)
    print("  ✓ valid limit order")


fn test_zero_quantity() raises:
    var caught = False
    try:
        _ = Order(
            id=3, symbol="X", side=Side.BUY,
            order_type=OrderType.MARKET, quantity=0.0,
            price=0.0, status=OrderStatus.PENDING,
        )
    except:
        caught = True
    assert_true(caught, "qty=0 should raise")
    print("  ✓ zero quantity rejected")


fn test_negative_quantity() raises:
    var caught = False
    try:
        _ = Order(
            id=4, symbol="X", side=Side.BUY,
            order_type=OrderType.MARKET, quantity=-1.0,
            price=0.0, status=OrderStatus.PENDING,
        )
    except:
        caught = True
    assert_true(caught, "qty<0 should raise")
    print("  ✓ negative quantity rejected")


fn test_limit_needs_price() raises:
    var caught = False
    try:
        _ = Order(
            id=5, symbol="X", side=Side.BUY,
            order_type=OrderType.LIMIT, quantity=1.0,
            price=0.0, status=OrderStatus.PENDING,
        )
    except:
        caught = True
    assert_true(caught, "limit with price=0 should raise")
    print("  ✓ limit without price rejected")


fn main() raises:
    print("Running order tests...")
    test_market_order()
    test_limit_order()
    test_zero_quantity()
    test_negative_quantity()
    test_limit_needs_price()
    print("All order tests passed! ✓")
