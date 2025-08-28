///|
fn ieee_parts_to_double(
  sign : Bool,
  ieeeExponent : Int,
  ieeeMantissa : Int64,
) -> Double {
  ((sign.to_int64() << 63) | (ieeeExponent.to_int64() << 52) | ieeeMantissa).reinterpret_as_double()
}