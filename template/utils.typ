#let assert_in_arr(needle, arr, item_name) = {
  if str(needle) not in arr {
    panic(
      "unknown " + item_name + " '" + str(needle) +
      "', expected one of: " + arr.map((k) => { "'" + str(k) + "'" }).join(", ")
    );
  }
}

#let assert_in_dict(needle, dict, item_name) = {
  assert_in_arr(needle, dict.keys(), item_name);
}

#let is_none(thing) = {
  if type(thing) == type(none) {
    true
  } else {
    false
  }
}

#let has_all_none(arr) = {
  for item in arr {
    if not is_none(item) {
      return false;
    }
  }
  true
}
