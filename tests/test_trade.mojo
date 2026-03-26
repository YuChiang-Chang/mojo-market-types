# test_trade.mojo — Tests for Trade validation

from std.testing import assert_true, assert_equal
from market_types import Trade, Side


fn test_valid() raises:
    var t = Trade(
        id=1, order_id=100, symbol="BTCUSDT",
        side=Side.BUY, quantity=0.5,
        price=50000.0, fee=25.0,
    )
    assert_equal(t.id, 1)
    assert_equal(t.order_id, 100)
    assert_equal(t.symbol, "BTCUSDT")
    assert_true(t.side == Side.BUY, "side BUY")
    assert_equal(t.quantity, 0.5)
    assert_equal(t.price, 50000.0)
    assert_equal(t.fee, 25.0)
    print("  ✓ valid trade")


fn test_zero_quantity() raises:
    var caught = False
    try:
        _ = Trade(
            id=2, order_id=101, symbol="X",
            side=Side.SELL, quantity=0.0,
            price=50000.0, fee=0.0,
        )
    except:
        caught = True
    assert_true(caught, "qty=0 should raise")
    print("  ✓ zero quantity rejected")


fn test_zero_price() raises:
    var caught = False
    try:
        _ = Trade(
            id=3, order_id=102, symbol="X",
            side=Side.BUY, quantity=1.0,
            price=0.0, fee=0.0,
        )
    except:
        caught = True
    assert_true(caught, "price=0 should raise")
    print("  ✓ zero price rejected")


fn test_string() raises:
    var t = Trade(
        id=1, order_id=100, symbol="ETHUSDT",
        side=Side.SELL, quantity=10.0,
        price=3000.0, fee=3.0,
    )
    var s = t.__str__()
    assert_true(s.__contains__("ETHUSDT"), "contains symbol")
    assert_true(s.__contains__("SELL"), "contains side")
    print("  ✓ string output")


fn main() raises:
    print("Running trade tests...")
    test_valid()
    test_zero_quantity()
    test_zero_price()
    test_string()
    print("All trade tests passed! ✓")
