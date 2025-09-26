#import "utils.typ": assert_in_dict

#let lang_ids = (
  cs: 0,
  en: 1,
);

#let lang_id(lang_abbr) = {
  assert_in_dict(lang_abbr, lang_ids, "language abbreviation");
  return lang_ids.at(lang_abbr);
};

// Typst will usually cache this - so we don't have to re-read the file each time
#let fetch_lang_items() = {
  return json("lang.json");
}

#let get_lang_item(lang_abbr, item_name) = {
  assert_in_dict(lang_abbr, lang_ids, "language abbreviation");
  let lang_items = fetch_lang_items();
  return lang_items.at(lang_abbr).at(item_name);
}
