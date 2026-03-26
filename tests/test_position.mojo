# test_position.mojo — Tests for Position side helpers

from std.testing import assert_true, assert_equal
from market_types import Position, PositionSide


fn test_flat() raises:
    var p = Position(
        symbol="BTCUSDT", side=PositionSide.FLAT,
        quantity=0.0, avg_price=0.0, unrealized_pnl=0.0,
    )
    assert_true(p.is_flat(), "should be flat")
    assert_true(not p.is_long(), "not long")
    assert_true(not p.is_short(), "not short")
    print("  ✓ flat position")


fn test_long() raises:
    var p = Position(
        symbol="ETHUSDT", side=PositionSide.LONG,
        quantity=10.0, avg_price=3000.0, unrealized_pnl=500.0,
    )
    assert_true(p.is_long(), "should be long")
    assert_equal(p.quantity, 10.0)
    assert_equal(p.avg_price, 3000.0)
    assert_equal(p.unrealized_pnl, 500.0)
    print("  ✓ long position")


fn test_short() raises:
    var p = Position(
        symbol="BTCUSDT", side=PositionSide.SHORT,
        quantity=1.0, avg_price=50000.0, unrealized_pnl=-200.0,
    )
    assert_true(p.is_short(), "should be short")
    assert_true(not p.is_long(), "not long")
    print("  ✓ short position")


fn test_string() raises:
    var p = Position(
        symbol="BTCUSDT", side=PositionSide.LONG,
        quantity=1.0, avg_price=50000.0, unrealized_pnl=1000.0,
    )
    var s = p.__str__()
    assert_true(s.__contains__("BTCUSDT"), "contains symbol")
    assert_true(s.__contains__("LONG"), "contains side")
    print("  ✓ string output")


fn main() raises:
    print("Running position tests...")
    test_flat()
    test_long()
    test_short()
    test_string()
    print("All position tests passed! ✓")
