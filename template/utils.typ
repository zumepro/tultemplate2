#let assert_in_dict(needle, dict, item_name) = {
  if str(needle) not in dict {
    panic(
      "unknown " + item_name + " '" + str(needle) +
      "', expected one of: " + dict.keys().map((k) => { "'" + str(k) + "'" }).join(", ")
    );
  }
}
