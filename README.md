# illusory0x0/ryu

A MoonBit implementation of the Ryu algorithm for fast floating-point to string conversion.

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
@ryu.to_string(3.1415926)      // "3.1415926"
@ryu.to_string(0.0)            // "0"
@ryu.to_string(1.0 / 0.0)      // "Infinity"
@ryu.to_string(-1.0 / 0.0)     // "-Infinity"
@ryu.to_string(0.0 / 0.0)      // "NaN"
```

### `output_to_logger(val : Double, logger : &Logger) -> Unit`

Outputs the string representation of a double-precision floating-point number to a logger.

```moonbit
let logger = Logger::new()
@ryu.output_to_logger(42.0, &logger)
// Logger will contain "42"
```

### `write_to_arrayview_byte(val : Double, bv : ArrayView[Byte]) -> Int`

Writes the string representation of a double-precision floating-point number to a byte array view and returns the number of bytes written.

```moonbit
let buffer = Array::make(32, 0.to_byte())
let bytes_written = @ryu.write_to_arrayview_byte(123.456, buffer[:])
// buffer now contains the UTF-8 bytes of "123.456"
// bytes_written contains the number of bytes written
```

## Examples

### Basic Usage

```moonbit
fn main {
    // Simple number conversion
    println(@ryu.to_string(42.0))           // "42"
    println(@ryu.to_string(3.14159))        // "3.14159"
    println(@ryu.to_string(1.23e-10))       // "1.23e-10"
    
    // Special values
    println(@ryu.to_string(0.0 / 0.0))      // "NaN"
    println(@ryu.to_string(1.0 / 0.0))      // "Infinity"
    println(@ryu.to_string(-1.0 / 0.0))     // "-Infinity"
}
```

### Scientific Notation

```moonbit
fn scientific_examples() {
    println(@ryu.to_string(1.0e-15))        // "1e-15"
    println(@ryu.to_string(1.0e+15))        // "1000000000000000"
    println(@ryu.to_string(1.23456789e+20)) // "1.23456789e+20"
}
```

### Edge Cases

```moonbit
fn edge_cases() {
    // Very small numbers
    println(@ryu.to_string(2.2250738585072014e-308))  // "2.2250738585072014e-308"
    
    // Very large numbers
    println(@ryu.to_string(1.7976931348623157e+308))  // "1.7976931348623157e+308"
    
    // Minimum positive value
    println(@ryu.to_string(5e-324))                   // "5e-324"
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