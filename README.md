# mojo-market-types

Quantitative trading base types for Mojo. 量化交易基礎型別庫。

## Quick Start

```mojo
from market_types import Side, OHLCVBar, Order, OrderType, OrderStatus

fn main() raises:
    var bar = OHLCVBar(1700000000000, 42000.0, 42500.0, 41800.0, 42300.0, 150.5)
    var order = Order(
        id=1, symbol="BTCUSDT", side=Side.BUY,
        order_type=OrderType.LIMIT, quantity=0.5,
        price=42000.0, status=OrderStatus.PENDING,
    )
```

## Project Structure

```
mojo-market-types/
├── market_types/          # Package — all types live here
│   ├── __init__.mojo      # ← AI: start here (API index)
│   ├── enums.mojo         # Side, PositionSide, OrderType, OrderStatus
│   ├── timestamp.mojo     # Timestamp
│   ├── timeframe.mojo     # Timeframe
│   ├── symbol.mojo        # Symbol
│   ├── ohlcv_bar.mojo     # OHLCVBar
│   ├── quote.mojo         # Quote
│   ├── order.mojo         # Order
│   ├── trade.mojo         # Trade
│   └── position.mojo      # Position
├── tests/                 # One test file per module
├── main.mojo              # Usage demo (run: mojo main.mojo)
└── README.md              # This file
```

## API Reference

### Enums (struct + comptime pattern)

| Type | Values | Check methods |
|------|--------|---------------|
| `Side` | `BUY`, `SELL` | `is_buy()`, `is_sell()` |
| `PositionSide` | `FLAT`, `LONG`, `SHORT` | `is_flat()`, `is_long()`, `is_short()` |
| `OrderType` | `MARKET`, `LIMIT` | `is_market()`, `is_limit()` |
| `OrderStatus` | `PENDING`, `FILLED`, `CANCELLED`, `REJECTED` | `is_pending()`, `is_filled()`, `is_cancelled()`, `is_rejected()` |

All enum structs support: `==`, `!=`, `__str__()`, `write_to()`.

### Timestamp

| Field | Type | Description |
|-------|------|-------------|
| `value` | `Int` | Unix milliseconds since epoch |

Supports: `<`, `<=`, `==`, `!=`, `>`, `>=`

### Timeframe

| Constant | Seconds | String |
|----------|---------|--------|
| `TICK` | 0 | `"TICK"` |
| `M1` | 60 | `"1m"` |
| `M5` | 300 | `"5m"` |
| `M15` | 900 | `"15m"` |
| `H1` | 3600 | `"1h"` |
| `H4` | 14400 | `"4h"` |
| `D1` | 86400 | `"1d"` |

Method: `seconds() -> Int`

### OHLCVBar

| Field | Type | Constraint |
|-------|------|------------|
| `timestamp` | `Int` | Unix ms |
| `open` | `Float64` | — |
| `high` | `Float64` | must be >= `low` |
| `low` | `Float64` | — |
| `close` | `Float64` | — |
| `volume` | `Float64` | must be >= 0 |

Constructor raises `Error` on invalid data.

### Quote

| Field | Type |
|-------|------|
| `timestamp` | `Int` |
| `bid` | `Float64` |
| `ask` | `Float64` |

Method: `spread() -> Float64` (returns `ask - bid`)

### Order

| Field | Type | Constraint |
|-------|------|------------|
| `id` | `Int` | — |
| `symbol` | `String` | — |
| `side` | `Side` | — |
| `order_type` | `OrderType` | — |
| `quantity` | `Float64` | must be > 0 |
| `price` | `Float64` | must be > 0 if LIMIT |
| `status` | `OrderStatus` | — |

### Trade

| Field | Type | Constraint |
|-------|------|------------|
| `id` | `Int` | — |
| `order_id` | `Int` | — |
| `symbol` | `String` | — |
| `side` | `Side` | — |
| `quantity` | `Float64` | must be > 0 |
| `price` | `Float64` | must be > 0 |
| `fee` | `Float64` | — |

### Position

| Field | Type |
|-------|------|
| `symbol` | `String` |
| `side` | `PositionSide` |
| `quantity` | `Float64` |
| `avg_price` | `Float64` |
| `unrealized_pnl` | `Float64` |

Methods: `is_flat()`, `is_long()`, `is_short()`

## Running

```bash
mojo main.mojo                              # demo
mojo run -I . tests/test_enums.mojo          # run one test
```

## Testing

```bash
mojo run -I . tests/test_enums.mojo
mojo run -I . tests/test_timeframe.mojo
mojo run -I . tests/test_ohlcv_bar.mojo
mojo run -I . tests/test_order.mojo
mojo run -I . tests/test_trade.mojo
mojo run -I . tests/test_position.mojo
```

## Mojo Version

Built and tested with **Mojo 0.26.2**.

Key Mojo conventions used:
- `comptime` (not `alias`) for compile-time constants
- `Writable` (not `Stringable`) for string representation
- `@fieldwise_init` + `ImplicitlyCopyable` for enum-like structs
- `String.write(self)` to delegate `__str__()` → `write_to()`
