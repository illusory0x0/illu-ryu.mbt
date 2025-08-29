// Copyright 2025 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// MoonBit implementation of Ryu, https://github.com/ulfjack/ryu
// This is a fork of the ryu crate adjusted to comply to the ECMAScript number-to-string algorithm,
//
// ==============================================================================================
// this file is copy from `https://github.com/moonbitlang/core/tree/main/double/internal/ryu`
// ==============================================================================================
//

///|
pub fn to_string(val : Double) -> String {
  let repr = ryu_to_repr(val)
  match repr {
    Nan => "NaN"
    Negative(Zero) => "0"
    Negative(Infinity) => "-Infinity"
    Negative(Normal(v)) =>
      to_arrayview_byte(v, true) |> string_from_arrayview_byte
    Positive(Zero) => "0"
    Positive(Infinity) => "Infinity"
    Positive(Normal(v)) =>
      to_arrayview_byte(v, false) |> string_from_arrayview_byte
  }
}

///|
pub fn output_to_logger(val : Double, logger : &Logger) -> Unit {
  let repr = ryu_to_repr(val)
  match repr {
    Nan => logger.write_string("NaN")
    Negative(Zero) => logger.write_string("0")
    Negative(Infinity) => logger.write_string("-Infinity")
    Negative(Normal(v)) => ryu_output(to_arrayview_byte(v, true), logger)
    Positive(Zero) => logger.write_string("0")
    Positive(Infinity) => logger.write_string("Infinity")
    Positive(Normal(v)) => ryu_output(to_arrayview_byte(v, false), logger)
  }
}

///|
pub fn write_to_arrayview_byte(val : Double, bv : ArrayView[Byte]) -> Int {
  let repr = ryu_to_repr(val)
  match repr {
    Nan => memcpy(bv, b"NaN")
    Negative(Zero) => memcpy(bv, b"0")
    Negative(Infinity) => memcpy(bv, b"-Infinity")
    Negative(Normal(v)) =>
      write_floating_decimal64_to_arrayview_byte(bv, v, true)
    Positive(Zero) => memcpy(bv, b"0")
    Positive(Infinity) => memcpy(bv, b"Infinity")
    Positive(Normal(v)) =>
      write_floating_decimal64_to_arrayview_byte(bv, v, false)
  }
}
