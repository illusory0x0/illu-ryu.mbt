///|
fn ieee_parts_to_double(
  sign : Bool,
  ieeeExponent : Int,
  ieeeMantissa : Int64,
) -> Double {
  ((sign.to_int64() << 63) | (ieeeExponent.to_int64() << 52) | ieeeMantissa).reinterpret_as_double()
}

///|
fn logger_to_string(val : Double) -> String {
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
fn write_to_string(val : Double) -> String {
  let buf = Array::make(80, b'\xff')
  let offset = write_to_arrayview_byte(val, buf)
  string_from_arrayview_byte(buf[0:offset])
}
