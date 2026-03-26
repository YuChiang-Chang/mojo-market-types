# test_ohlcv_bar.mojo — Tests for OHLCVBar validation

from std.testing import assert_true, assert_equal
from market_types import OHLCVBar


fn test_valid() raises:
    var bar = OHLCVBar(1000, 100.0, 110.0, 90.0, 105.0, 5000.0)
    assert_equal(bar.timestamp, 1000)
    assert_equal(bar.open, 100.0)
    assert_equal(bar.high, 110.0)
    assert_equal(bar.low, 90.0)
    assert_equal(bar.close, 105.0)
    assert_equal(bar.volume, 5000.0)
    print("  ✓ valid bar")


fn test_high_lt_low() raises:
    var caught = False
    try:
        _ = OHLCVBar(1000, 100.0, 80.0, 90.0, 105.0, 5000.0)
    except:
        caught = True
    assert_true(caught, "high < low should raise")
    print("  ✓ high < low rejected")


fn test_negative_volume() raises:
    var caught = False
    try:
        _ = OHLCVBar(1000, 100.0, 110.0, 90.0, 105.0, -1.0)
    except:
        caught = True
    assert_true(caught, "negative volume should raise")
    print("  ✓ negative volume rejected")


fn test_zero_volume() raises:
    var bar = OHLCVBar(1000, 100.0, 110.0, 90.0, 105.0, 0.0)
    assert_equal(bar.volume, 0.0)
    print("  ✓ zero volume OK")


fn test_doji() raises:
    var bar = OHLCVBar(1000, 100.0, 100.0, 100.0, 100.0, 1000.0)
    assert_equal(bar.high, bar.low)
    print("  ✓ doji (high==low) OK")


fn main() raises:
    print("Running OHLCVBar tests...")
    test_valid()
    test_high_lt_low()
    test_negative_volume()
    test_zero_volume()
    test_doji()
    print("All OHLCVBar tests passed! ✓")
