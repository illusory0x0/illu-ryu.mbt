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
  ryu_to_logger(val, b)
  b.to_string()
}
