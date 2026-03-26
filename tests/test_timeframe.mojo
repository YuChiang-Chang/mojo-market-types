# test_timeframe.mojo — Tests for Timeframe constants, comparison, string

from std.testing import assert_true, assert_equal
from market_types import Timeframe


fn test_constants() raises:
    assert_equal(Timeframe.TICK.seconds(), 0)
    assert_equal(Timeframe.M1.seconds(), 60)
    assert_equal(Timeframe.M5.seconds(), 300)
    assert_equal(Timeframe.M15.seconds(), 900)
    assert_equal(Timeframe.H1.seconds(), 3600)
    assert_equal(Timeframe.H4.seconds(), 14400)
    assert_equal(Timeframe.D1.seconds(), 86400)
    print("  ✓ constants")


fn test_comparison() raises:
    var m1 = Timeframe.M1
    var m5 = Timeframe.M5
    assert_true(m1 == Timeframe.M1, "M1 == M1")
    assert_true(m1 != m5, "M1 != M5")
    print("  ✓ comparison")


fn test_string() raises:
    assert_equal(Timeframe.TICK.__str__(), "TICK")
    assert_equal(Timeframe.M1.__str__(), "1m")
    assert_equal(Timeframe.M5.__str__(), "5m")
    assert_equal(Timeframe.M15.__str__(), "15m")
    assert_equal(Timeframe.H1.__str__(), "1h")
    assert_equal(Timeframe.H4.__str__(), "4h")
    assert_equal(Timeframe.D1.__str__(), "1d")
    print("  ✓ string")


fn main() raises:
    print("Running timeframe tests...")
    test_constants()
    test_comparison()
    test_string()
    print("All timeframe tests passed! ✓")
