# test_enums.mojo — Tests for Side, PositionSide, OrderType, OrderStatus

from std.testing import assert_true, assert_equal, assert_false
from market_types import Side, PositionSide, OrderType, OrderStatus


fn test_side() raises:
    var buy = Side.BUY
    var sell = Side.SELL
    assert_true(buy.is_buy(), "BUY should be buy")
    assert_true(sell.is_sell(), "SELL should be sell")
    assert_false(buy.is_sell(), "BUY should not be sell")
    assert_true(buy == Side.BUY, "BUY == BUY")
    assert_true(buy != sell, "BUY != SELL")
    assert_equal(buy.__str__(), "BUY")
    assert_equal(sell.__str__(), "SELL")
    print("  ✓ Side")


fn test_position_side() raises:
    var flat = PositionSide.FLAT
    var long = PositionSide.LONG
    var short = PositionSide.SHORT
    assert_true(flat.is_flat(), "FLAT")
    assert_true(long.is_long(), "LONG")
    assert_true(short.is_short(), "SHORT")
    assert_true(flat != long, "FLAT != LONG")
    assert_equal(flat.__str__(), "FLAT")
    assert_equal(long.__str__(), "LONG")
    assert_equal(short.__str__(), "SHORT")
    print("  ✓ PositionSide")


fn test_order_type() raises:
    var market = OrderType.MARKET
    var limit = OrderType.LIMIT
    assert_true(market.is_market(), "MARKET")
    assert_true(limit.is_limit(), "LIMIT")
    assert_false(market.is_limit(), "not LIMIT")
    assert_true(market != limit, "MARKET != LIMIT")
    assert_equal(market.__str__(), "MARKET")
    assert_equal(limit.__str__(), "LIMIT")
    print("  ✓ OrderType")


fn test_order_status() raises:
    assert_true(OrderStatus.PENDING.is_pending(), "PENDING")
    assert_true(OrderStatus.FILLED.is_filled(), "FILLED")
    assert_true(OrderStatus.CANCELLED.is_cancelled(), "CANCELLED")
    assert_true(OrderStatus.REJECTED.is_rejected(), "REJECTED")
    assert_equal(OrderStatus.PENDING.__str__(), "PENDING")
    assert_equal(OrderStatus.FILLED.__str__(), "FILLED")
    assert_equal(OrderStatus.CANCELLED.__str__(), "CANCELLED")
    assert_equal(OrderStatus.REJECTED.__str__(), "REJECTED")
    print("  ✓ OrderStatus")


fn main() raises:
    print("Running enum tests...")
    test_side()
    test_position_side()
    test_order_type()
    test_order_status()
    print("All enum tests passed! ✓")
