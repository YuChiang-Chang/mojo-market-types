# ===----------------------------------------------------------------------=== #
# symbol.mojo — Trading instrument identifier (交易標的)
#
# A thin wrapper around String for type safety.
#
# Exports: Symbol
# ===----------------------------------------------------------------------=== #


struct Symbol(Writable):
    """Trading instrument identifier. 交易標的符號。

    Wraps a String to provide type-safe instrument references
    (e.g. "BTCUSDT", "AAPL", "EUR/USD").

    Fields:
        name: String — The instrument ticker / symbol name.

    Example:
        var sym = Symbol("BTCUSDT")
        print(sym.__str__())    # "BTCUSDT"
        if sym == Symbol("BTCUSDT"):
            print("match!")
    """

    var name: String
    """The instrument ticker string."""

    fn __init__(out self, name: String):
        self.name = name

    fn __copyinit__(out self, copy: Symbol):
        self.name = copy.name

    fn __eq__(self, other: Symbol) -> Bool:
        return self.name == other.name

    fn __ne__(self, other: Symbol) -> Bool:
        return self.name != other.name

    fn write_to[W: Writer](self, mut writer: W):
        writer.write(self.name)

    fn __str__(self) -> String:
        return String.write(self)
