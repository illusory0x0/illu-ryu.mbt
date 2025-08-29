# illusory0x0/ryu

A MoonBit implementation of the Ryu algorithm for fast floating-point to string conversion.

> **Note**: This file is copied from `https://github.com/moonbitlang/core/tree/main/double/internal/ryu`

## Overview

This package provides an efficient implementation of the Ryu algorithm, which converts IEEE 754 double-precision floating-point numbers to their string representation. The implementation is based on the original [Ryu algorithm](https://github.com/ulfjack/ryu) and has been adapted to comply with the ECMAScript number-to-string algorithm.

## Features

- **Fast conversion**: Optimized algorithm for converting `Double` values to strings
- **Multiple output formats**: Support for string output, logger output, and byte array output
- **ECMAScript compliance**: Follows ECMAScript number-to-string specification
- **Comprehensive testing**: Extensively tested with edge cases and boundary conditions

## API

### `to_string(val : Double) -> String`

Converts a double-precision floating-point number to its string representation.

```moonbit
test "to_string examples" {
  inspect(to_string(3.1415926), content="3.1415926")
  inspect(to_string(0.0), content="0")
  inspect(to_string(1.0 / 0.0), content="Infinity")
  inspect(to_string(-1.0 / 0.0), content="-Infinity")
  inspect(to_string(0.0 / 0.0), content="NaN")
}
```

### `output_to_logger(val : Double, logger : &Logger) -> Unit`

Outputs the string representation of a double-precision floating-point number to a logger.

```moonbit
test "output_to_logger example" {
  let logger = StringBuilder::new(size_hint=60)
  output_to_logger(42.0, logger)
  inspect(logger.to_string(), content="42")
}
```

### `write_to_arrayview_byte(val : Double, bv : ArrayView[Byte]) -> Int`

Writes the string representation of a double-precision floating-point number to a byte array view and returns the number of bytes written.

```moonbit
test "write_to_arrayview_byte example" {
  let buffer : Array[Byte] = Array::make(32, b'\xff')
  let bytes_written = write_to_arrayview_byte(123.456, buffer[:])
  // buffer now contains the UTF-8 bytes of "123.456"
  inspect(bytes_written, content="7")
  let result_str = StringBuilder::new()
  for i in 0..<bytes_written {
    result_str.write_char(buffer[i].to_char())
  }
  inspect(result_str.to_string(), content="123.456")
}
```

## Examples

### Basic Usage

```moonbit
test "basic usage examples" {
  // Simple number conversion
  inspect(to_string(42.0), content="42")
  inspect(to_string(3.14159), content="3.14159")
  inspect(to_string(1.23e-10), content="1.23e-10")
  
  // Special values
  inspect(to_string(0.0 / 0.0), content="NaN")
  inspect(to_string(1.0 / 0.0), content="Infinity")
  inspect(to_string(-1.0 / 0.0), content="-Infinity")
}
```

### Scientific Notation

```moonbit
test "scientific notation examples" {
  inspect(to_string(1.0e-15), content="1e-15")
  inspect(to_string(1.0e+15), content="1000000000000000")
  inspect(to_string(1.23456789e+20), content="123456789000000000000")
}
```

### Edge Cases

```moonbit
test "edge cases" {
  // Very small numbers
  inspect(to_string(2.2250738585072014e-308), content="2.2250738585072014e-308")
  
  // Very large numbers
  inspect(to_string(1.7976931348623157e+308), content="1.7976931348623157e+308")
  
  // Minimum positive value
  inspect(to_string(5.0e-324), content="5e-324")
}
```

## Implementation Details

This implementation is forked from the [MoonBit Core library's ryu module](https://github.com/moonbitlang/core/tree/main/double/internal/ryu) and provides:

- Optimized conversion algorithms for different number ranges
- Proper handling of trailing zeros
- Support for subnormal numbers
- Compliance with IEEE 754 standards

## Performance

The Ryu algorithm provides significant performance improvements over naive floating-point to string conversion methods by:

- Avoiding expensive division operations
- Using precomputed lookup tables
- Implementing optimized algorithms for different number ranges

## License

Licensed under the Apache License, Version 2.0. See the [LICENSE](LICENSE) file for details.

## Credits

- Original Ryu algorithm by Ulf Adams
- MoonBit implementation adapted from moonbitlang/core
- ECMAScript compliance adjustments
