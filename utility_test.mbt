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
fn ieee_parts_to_double(
  sign : Bool,
  ieeeExponent : Int,
  ieeeMantissa : Int64,
) -> Double {
  ((sign.to_int64() << 63) | (ieeeExponent.to_int64() << 52) | ieeeMantissa).reinterpret_as_double()
}

///|
fn otl_to_string(val : Double) -> String {
  let b = StringBuilder::new(size_hint=60)
  output_to_logger(val, b)
  b.to_string()
}

///|
fn string_from_arrayview_byte(bv : ArrayView[Byte]) -> String {
  let buf = StringBuilder::new(size_hint=bv.length() << 1)
  for b in bv {
    buf.write_char(b.to_char())
  }
  buf.to_string()
}

///|
fn wtab_to_string(val : Double) -> String {
  let buf = Array::make(80, b'\xff')
  let offset = write_to_arrayview_byte(val, buf)
  string_from_arrayview_byte(buf[0:offset])
}
